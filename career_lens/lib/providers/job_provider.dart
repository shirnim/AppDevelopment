import 'package:flutter/material.dart';
import 'package:job_finder_pro/models/job.dart';
import 'package:job_finder_pro/models/search_filters.dart';
import 'package:job_finder_pro/services/api_service.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;
  SearchFilters _filters = SearchFilters();
  int _currentPage = 1;
  int _totalJobs = 0;
  int _totalPages = 0;
  bool _hasNextPage = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  SearchFilters get filters => _filters;
  int get currentPage => _currentPage;
  int get totalJobs => _totalJobs;
  int get totalPages => _totalPages;
  bool get hasNextPage => _hasNextPage;

  void updateFilters(SearchFilters newFilters) {
    _filters = newFilters;
    notifyListeners();
  }

  Future<void> searchJobs({bool loadMore = false}) async {
    if (_isLoading) return;

    if (!loadMore) {
      _currentPage = 1;
      _jobs.clear();
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.searchJobs(
        filters: _filters,
        page: _currentPage,
      );

      if (loadMore) {
        _jobs.addAll(response.jobs);
      } else {
        _jobs = response.jobs;
      }

      _totalJobs = response.totalJobs;
      _totalPages = response.totalPages;
      _hasNextPage = response.hasNextPage;

      if (loadMore && response.jobs.isNotEmpty) {
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreJobs() async {
    if (_hasNextPage && !_isLoading) {
      _currentPage++;
      await searchJobs(loadMore: true);
    }
  }

  void clearSearch() {
    _jobs.clear();
    _filters = SearchFilters();
    _currentPage = 1;
    _totalJobs = 0;
    _totalPages = 0;
    _hasNextPage = false;
    _error = null;
    notifyListeners();
  }
}