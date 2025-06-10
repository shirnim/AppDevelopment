from flask import Flask, render_template, request, send_file, redirect, url_for, jsonify
import requests
import pandas as pd
from io import BytesIO
import re
from collections import Counter
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import json
from datetime import datetime, timedelta
import sqlite3
import os

app = Flask(__name__)

# Download required NLTK data
try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    nltk.download('punkt')

try:
    nltk.data.find('corpora/stopwords')
except LookupError:
    nltk.download('stopwords')

API_KEY = "946f8fc0c6msh4a22845aa477a03p1e9fcejsn192a690f06a6"
API_HOST = "jsearch.p.rapidapi.com"
HEADERS = {
    "X-RapidAPI-Key": API_KEY,
    "X-RapidAPI-Host": API_HOST
}

# Initialize database
def init_db():
    conn = sqlite3.connect('job_analytics.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS searches (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            query TEXT,
            location TEXT,
            job_type TEXT,
            experience_level TEXT,
            date_posted TEXT,
            results_count INTEGER,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS job_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            job_id TEXT UNIQUE,
            title TEXT,
            company TEXT,
            location TEXT,
            employment_type TEXT,
            posted_date TEXT,
            responsibilities TEXT,
            qualifications TEXT,
            benefits TEXT,
            salary TEXT,
            search_id INTEGER,
            FOREIGN KEY (search_id) REFERENCES searches (id)
        )
    ''')
    conn.commit()
    conn.close()

init_db()

def extract_key_insights(text_list, max_insights=5):
    """Extract key insights from responsibilities or qualifications using NLP"""
    if not text_list:
        return []
    
    # Combine all text
    combined_text = ' '.join(text_list).lower()
    
    # Remove common job posting phrases
    noise_phrases = [
        'experience in', 'knowledge of', 'ability to', 'responsible for',
        'working with', 'experience with', 'strong', 'excellent',
        'good', 'required', 'preferred', 'must have', 'should have'
    ]
    
    for phrase in noise_phrases:
        combined_text = combined_text.replace(phrase, '')
    
    # Tokenize and remove stopwords
    stop_words = set(stopwords.words('english'))
    words = word_tokenize(combined_text)
    
    # Filter for meaningful terms (length > 2, not stopwords, alphanumeric)
    meaningful_words = [
        word for word in words 
        if len(word) > 2 and word not in stop_words and word.isalnum()
    ]
    
    # Count frequency and get top terms
    word_freq = Counter(meaningful_words)
    
    # Extract key phrases (2-3 word combinations)
    phrases = []
    for i in range(len(words) - 1):
        if words[i] not in stop_words and words[i+1] not in stop_words:
            phrase = f"{words[i]} {words[i+1]}"
            if len(phrase) > 5:  # Avoid very short phrases
                phrases.append(phrase)
    
    phrase_freq = Counter(phrases)
    
    # Combine single words and phrases
    insights = []
    
    # Add top phrases first
    for phrase, count in phrase_freq.most_common(3):
        if count > 1:  # Only include phrases that appear multiple times
            insights.append(phrase.title())
    
    # Add top single words
    for word, count in word_freq.most_common(max_insights):
        if len(insights) < max_insights and word not in ' '.join(insights).lower():
            insights.append(word.title())
    
    return insights[:max_insights]

def save_search_data(query, location, job_type, experience_level, date_posted, jobs):
    """Save search data and job details to database"""
    conn = sqlite3.connect('job_analytics.db')
    cursor = conn.cursor()
    
    # Save search
    cursor.execute('''
        INSERT INTO searches (query, location, job_type, experience_level, date_posted, results_count)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', (query, location, job_type, experience_level, date_posted, len(jobs)))
    
    search_id = cursor.lastrowid
    
    # Save job details
    for job in jobs:
        responsibilities = json.dumps(job.get('job_highlights', {}).get('Responsibilities', []))
        qualifications = json.dumps(job.get('job_highlights', {}).get('Qualifications', []))
        benefits = json.dumps(job.get('job_highlights', {}).get('Benefits', []))
        
        cursor.execute('''
            INSERT OR REPLACE INTO job_data 
            (job_id, title, company, location, employment_type, posted_date, 
             responsibilities, qualifications, benefits, salary, search_id)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            job.get('job_id'),
            job.get('job_title'),
            job.get('employer_name'),
            job.get('job_location'),
            job.get('job_employment_type'),
            job.get('job_posted_at'),
            responsibilities,
            qualifications,
            benefits,
            job.get('job_salary'),
            search_id
        ))
    
    conn.commit()
    conn.close()
    return search_id

def get_analytics_data():
    """Get analytics data from database"""
    conn = sqlite3.connect('job_analytics.db')
    
    # Search trends
    search_trends = pd.read_sql_query('''
        SELECT query, COUNT(*) as search_count, AVG(results_count) as avg_results
        FROM searches 
        WHERE timestamp >= datetime('now', '-30 days')
        GROUP BY query 
        ORDER BY search_count DESC 
        LIMIT 10
    ''', conn)
    
    # Location trends
    location_trends = pd.read_sql_query('''
        SELECT location, COUNT(*) as job_count
        FROM job_data 
        WHERE location IS NOT NULL AND location != ''
        GROUP BY location 
        ORDER BY job_count DESC 
        LIMIT 10
    ''', conn)
    
    # Company trends
    company_trends = pd.read_sql_query('''
        SELECT company, COUNT(*) as job_count
        FROM job_data 
        WHERE company IS NOT NULL AND company != ''
        GROUP BY company 
        ORDER BY job_count DESC 
        LIMIT 10
    ''', conn)
    
    # Employment type distribution
    employment_dist = pd.read_sql_query('''
        SELECT employment_type, COUNT(*) as count
        FROM job_data 
        WHERE employment_type IS NOT NULL
        GROUP BY employment_type
    ''', conn)
    
    # Recent search activity
    recent_activity = pd.read_sql_query('''
        SELECT DATE(timestamp) as date, COUNT(*) as searches
        FROM searches 
        WHERE timestamp >= datetime('now', '-7 days')
        GROUP BY DATE(timestamp)
        ORDER BY date
    ''', conn)
    
    conn.close()
    
    return {
        'search_trends': search_trends.to_dict('records'),
        'location_trends': location_trends.to_dict('records'),
        'company_trends': company_trends.to_dict('records'),
        'employment_dist': employment_dist.to_dict('records'),
        'recent_activity': recent_activity.to_dict('records')
    }

last_results = []
last_query = ""

@app.route("/", methods=["GET", "POST"])
def index():
    global last_results, last_query
    
    # Get form data
    query = request.form.get("query") if request.method == "POST" else request.args.get("query", "")
    location = request.form.get("location") if request.method == "POST" else request.args.get("location", "")
    job_type = request.form.get("job_type") if request.method == "POST" else request.args.get("job_type", "")
    experience_level = request.form.get("experience_level") if request.method == "POST" else request.args.get("experience_level", "")
    date_posted = request.form.get("date_posted") if request.method == "POST" else request.args.get("date_posted", "")
    page = int(request.args.get("page", 1))
    
    jobs = []
    total_jobs = 0
    total_pages = 0

    if query:
        url = "https://jsearch.p.rapidapi.com/search"
        
        # Build search query with filters
        search_query = query
        if location:
            search_query += f" in {location}"
        
        params = {
            "query": search_query,
            "page": page,
            "num_pages": 1
        }
        
        # Add employment type filter
        if job_type:
            params["employment_types"] = job_type
            
        # Add experience level filter
        if experience_level:
            params["job_requirements"] = experience_level
            
        # Add date posted filter
        if date_posted:
            params["date_posted"] = date_posted
        
        response = requests.get(url, headers=HEADERS, params=params)
        if response.status_code == 200:
            data = response.json()
            jobs = data.get("data", [])
            
            # Get pagination info from API response
            total_jobs = data.get("total_jobs", 0)
            total_pages = data.get("total_pages", 0)
            
            # If API doesn't provide total info, estimate based on results
            if not total_jobs and jobs:
                if len(jobs) == 10:
                    total_jobs = f"{(page - 1) * 10 + len(jobs)}+"
                else:
                    total_jobs = (page - 1) * 10 + len(jobs)
            elif not total_jobs:
                total_jobs = 0
            
            # Process jobs with ML insights
            for job in jobs:
                # Extract key insights from responsibilities
                responsibilities = job.get('job_highlights', {}).get('Responsibilities', [])
                job['key_responsibilities'] = extract_key_insights(responsibilities, 3)
                
                # Extract key insights from qualifications
                qualifications = job.get('job_highlights', {}).get('Qualifications', [])
                job['key_qualifications'] = extract_key_insights(qualifications, 3)
                
            last_results = jobs
            last_query = query
            
            # Save search data for analytics
            if jobs:
                save_search_data(query, location, job_type, experience_level, date_posted, jobs)

    return render_template("index.html", 
                         jobs=jobs, 
                         query=query, 
                         location=location,
                         job_type=job_type,
                         experience_level=experience_level,
                         date_posted=date_posted,
                         page=page,
                         total_jobs=total_jobs,
                         total_pages=total_pages,
                         has_next_page=len(jobs) == 10,
                         results_start=(page - 1) * 10 + 1 if jobs else 0,
                         results_end=(page - 1) * 10 + len(jobs) if jobs else 0)

@app.route("/analytics")
def analytics():
    analytics_data = get_analytics_data()
    return render_template("analytics.html", analytics=analytics_data)

@app.route("/export")
def export():
    global last_results
    if not last_results:
        return redirect(url_for("index"))

    # Enhanced export with ML insights
    export_data = []
    for job in last_results:
        export_data.append({
            "Title": job.get("job_title"),
            "Company": job.get("employer_name"),
            "Location": job.get("job_location"),
            "Type": job.get("job_employment_type"),
            "Posted": job.get("job_posted_at"),
            "Key Responsibilities": ", ".join(job.get("key_responsibilities", [])),
            "Key Qualifications": ", ".join(job.get("key_qualifications", [])),
            "Apply Link": job.get("job_apply_link")
        })

    df = pd.DataFrame(export_data)

    output = BytesIO()
    with pd.ExcelWriter(output, engine="xlsxwriter") as writer:
        df.to_excel(writer, index=False, sheet_name="Jobs")
        
        # Get workbook and worksheet
        workbook = writer.book
        worksheet = writer.sheets['Jobs']
        
        # Add formatting
        header_format = workbook.add_format({
            'bold': True,
            'text_wrap': True,
            'valign': 'top',
            'fg_color': '#D7E4BC',
            'border': 1
        })
        
        # Write headers with formatting
        for col_num, value in enumerate(df.columns.values):
            worksheet.write(0, col_num, value, header_format)
        
        # Auto-adjust column widths
        for i, col in enumerate(df.columns):
            max_length = max(df[col].astype(str).map(len).max(), len(col))
            worksheet.set_column(i, i, min(max_length + 2, 50))

    output.seek(0)
    return send_file(output, as_attachment=True, download_name="jobs_with_insights.xlsx", 
                    mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

@app.route("/job/<job_id>")
def job_detail(job_id):
    url = "https://jsearch.p.rapidapi.com/job-details"
    params = {"job_id": job_id, "country": "us", "language": "en"}
    response = requests.get(url, headers=HEADERS, params=params)
    job = response.json().get("data", [{}])[0]
    
    # Add ML insights to job details
    if job:
        responsibilities = job.get('job_highlights', {}).get('Responsibilities', [])
        job['key_responsibilities'] = extract_key_insights(responsibilities, 5)
        
        qualifications = job.get('job_highlights', {}).get('Qualifications', [])
        job['key_qualifications'] = extract_key_insights(qualifications, 5)
    
    return render_template("job_detail.html", job=job)

if __name__ == "__main__":
    app.run(debug=True)