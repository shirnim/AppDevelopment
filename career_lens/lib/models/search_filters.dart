class SearchFilters {
  final String query;
  final String location;
  final String jobType;
  final String experienceLevel;
  final String datePosted;

  SearchFilters({
    this.query = '',
    this.location = '',
    this.jobType = '',
    this.experienceLevel = '',
    this.datePosted = '',
  });

  SearchFilters copyWith({
    String? query,
    String? location,
    String? jobType,
    String? experienceLevel,
    String? datePosted,
  }) {
    return SearchFilters(
      query: query ?? this.query,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      datePosted: datePosted ?? this.datePosted,
    );
  }

  bool get hasActiveFilters {
    return location.isNotEmpty ||
        jobType.isNotEmpty ||
        experienceLevel.isNotEmpty ||
        datePosted.isNotEmpty;
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (query.isNotEmpty) params['query'] = query;
    if (location.isNotEmpty) params['location'] = location;
    if (jobType.isNotEmpty) params['employment_types'] = jobType;
    if (experienceLevel.isNotEmpty) params['job_requirements'] = experienceLevel;
    if (datePosted.isNotEmpty) params['date_posted'] = datePosted;
    return params;
  }
}