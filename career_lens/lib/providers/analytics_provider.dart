import 'package:flutter/material.dart';

class AnalyticsProvider extends ChangeNotifier {
  Map<String, dynamic> _analyticsData = {};
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic> get analyticsData => _analyticsData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAnalytics() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate analytics data loading
      await Future.delayed(const Duration(seconds: 1));
      
      _analyticsData = {
        'search_trends': [
          {'query': 'Software Engineer', 'search_count': 45, 'avg_results': 120},
          {'query': 'Data Scientist', 'search_count': 32, 'avg_results': 85},
          {'query': 'Product Manager', 'search_count': 28, 'avg_results': 95},
        ],
        'location_trends': [
          {'location': 'San Francisco, CA', 'job_count': 234},
          {'location': 'New York, NY', 'job_count': 198},
          {'location': 'Seattle, WA', 'job_count': 156},
        ],
        'company_trends': [
          {'company': 'Google', 'job_count': 45},
          {'company': 'Microsoft', 'job_count': 38},
          {'company': 'Amazon', 'job_count': 32},
        ],
      };
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}