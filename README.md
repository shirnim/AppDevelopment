# JobFinder Pro - Complete Job Search Platform

A comprehensive job search platform featuring both a Flutter mobile app and a Flask web application with AI-powered insights.

## 🚀 Features

### Mobile App (Flutter)
- **Modern Material Design 3** interface
- **Advanced job search** with multiple filters
- **AI-powered insights** for job requirements
- **Responsive design** for all screen sizes
- **Real-time job data** from JSearch API
- **Analytics dashboard** with market trends

### Web Application (Flask)
- **AI-powered job analysis** using NLTK
- **Advanced filtering** and search capabilities
- **Analytics dashboard** with data visualization
- **Export functionality** to Excel with insights
- **Responsive web design**
- **Job market trends** and statistics

## 🛠 Technology Stack

### Mobile App
- **Flutter** 3.32.0
- **Dart** 3.0+
- **Provider** for state management
- **HTTP** for API communication
- **Material Design 3** components

### Web Application
- **Flask** (Python web framework)
- **NLTK** for natural language processing
- **Pandas** for data manipulation
- **SQLite** for analytics storage
- **Bootstrap 5** for responsive UI

## 📱 Mobile App Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
├── providers/                # State management
├── screens/                  # App screens
├── services/                 # API services
├── utils/                    # Utilities & theme
└── widgets/                  # Reusable widgets
```

## 🌐 Web Application Structure

```
job_finder/
├── app.py                    # Flask application
├── templates/                # HTML templates
├── requirements.txt          # Python dependencies
└── job_analytics.db         # SQLite database
```

## 🚀 Getting Started

### Mobile App Setup

1. **Install Flutter** (3.0.0 or higher)
2. **Clone the repository**
   ```bash
   cd career_lens
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```

### Web Application Setup

1. **Install Python dependencies**
   ```bash
   cd job_finder
   pip install -r requirements.txt
   ```
2. **Run the Flask app**
   ```bash
   python app.py
   ```

## 🔧 Configuration

### API Setup
Update the API credentials in both applications:
- Mobile: `lib/services/api_service.dart`
- Web: `app.py`

```dart
// Mobile App
static const String apiKey = 'your-rapidapi-key';
```

```python
# Web App
API_KEY = "your-rapidapi-key"
```

## 📊 Features Overview

### AI-Powered Insights
- **Key responsibilities** extraction from job descriptions
- **Required qualifications** analysis
- **Skills matching** and highlighting
- **Market trends** analysis

### Advanced Search
- **Location-based** filtering
- **Job type** selection (Full-time, Part-time, Contract, Internship)
- **Experience level** filtering
- **Date posted** filters
- **Salary range** filtering

### Analytics Dashboard
- **Search trends** and popular terms
- **Location-based** job statistics
- **Company hiring** trends
- **Market insights** and data visualization

## 🎨 Design System

### Color Palette
- **Primary**: #2563EB (Blue)
- **Success**: #059669 (Green)
- **Background**: #F8FAFC (Light Gray)
- **Text**: #1E293B (Dark Gray)

### Typography
- **Font Family**: Inter
- **Weights**: 400, 500, 600, 700
- **Responsive** sizing

## 📱 Mobile App Features

- **Cross-platform** (iOS & Android)
- **Material Design 3** components
- **Smooth animations** and transitions
- **Offline support** (planned)
- **Push notifications** (planned)

## 🌐 Web App Features

- **Responsive design** for all devices
- **Progressive Web App** capabilities
- **Export to Excel** with insights
- **Real-time analytics**
- **SEO optimized**

## 🔒 Security

- **API key protection**
- **Input validation**
- **CORS configuration**
- **Rate limiting** (planned)

## 📈 Performance

- **Optimized API calls**
- **Image caching**
- **Lazy loading**
- **Efficient state management**

## 🧪 Testing

### Mobile App
```bash
flutter test
```

### Web Application
```bash
python -m pytest
```

## 🚀 Deployment

### Mobile App
- **Android**: Build APK/AAB for Google Play Store
- **iOS**: Build IPA for Apple App Store

### Web Application
- **Docker** containerization
- **Cloud deployment** (AWS, GCP, Azure)
- **Database migration** to production

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For support and questions:
- Open an issue in the repository
- Contact the development team
- Check the documentation

## 🔮 Roadmap

- [ ] User authentication and profiles
- [ ] Job application tracking
- [ ] Salary comparison tools
- [ ] Company reviews integration
- [ ] Advanced ML recommendations
- [ ] Real-time notifications
- [ ] Social features
- [ ] API rate optimization

---

**JobFinder Pro** - Find your dream job with AI-powered insights! 🚀