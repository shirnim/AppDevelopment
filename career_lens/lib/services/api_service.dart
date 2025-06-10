import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_finder_pro/models/job.dart';
import 'package:job_finder_pro/models/search_filters.dart';

class ApiService {
  static const String baseUrl = 'https://jsearch.p.rapidapi.com';
  static const String apiKey = '946f8fc0c6msh4a22845aa477a03p1e9fcejsn192a690f06a6';
  static const String apiHost = 'jsearch.p.rapidapi.com';

  static const Map<String, String> headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': apiHost,
    'Content-Type': 'application/json',
  };

  static Future<JobSearchResponse> searchJobs({
    required SearchFilters filters,
    int page = 1,
  }) async {
    try {
      final params = filters.toQueryParams();
      params['page'] = page.toString();
      params['num_pages'] = '1';

      // Build search query with location
      String searchQuery = filters.query;
      if (filters.location.isNotEmpty) {
        searchQuery += ' in ${filters.location}';
      }
      params['query'] = searchQuery;

      final uri = Uri.parse('$baseUrl/search').replace(queryParameters: params);
      
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final jobs = (data['data'] as List?)
            ?.map((jobJson) => Job.fromJson(jobJson))
            .toList() ?? [];

        return JobSearchResponse(
          jobs: jobs,
          totalJobs: data['total_jobs'] ?? 0,
          totalPages: data['total_pages'] ?? 0,
          currentPage: page,
        );
      } else {
        throw Exception('Failed to search jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching jobs: $e');
    }
  }

  static Future<Job?> getJobDetails(String jobId) async {
    try {
      final params = {
        'job_id': jobId,
        'country': 'us',
        'language': 'en',
      };

      final uri = Uri.parse('$baseUrl/job-details').replace(queryParameters: params);
      
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final jobData = data['data'];
        
        if (jobData != null && jobData.isNotEmpty) {
          return Job.fromJson(jobData[0]);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching job details: $e');
    }
  }
}

class JobSearchResponse {
  final List<Job> jobs;
  final int totalJobs;
  final int totalPages;
  final int currentPage;

  JobSearchResponse({
    required this.jobs,
    required this.totalJobs,
    required this.totalPages,
    required this.currentPage,
  });

  bool get hasNextPage => currentPage < totalPages;
}