import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';
import 'package:job_finder_pro/widgets/search_header.dart';
import 'package:job_finder_pro/widgets/search_filters.dart';
import 'package:job_finder_pro/widgets/job_list.dart';
import 'package:job_finder_pro/widgets/active_filters.dart';
import 'package:job_finder_pro/utils/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search and filters
            Container(
              decoration: const BoxDecoration(
                color: AppTheme.surfaceColor,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.work_rounded,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'JobFinder Pro',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              Text(
                                'Find your dream job',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showFilters = !_showFilters;
                            });
                          },
                          icon: Icon(
                            _showFilters ? Icons.filter_list_off_rounded : Icons.tune_rounded,
                            color: _showFilters ? AppTheme.primaryColor : AppTheme.textSecondary,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: _showFilters 
                                ? AppTheme.primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Search Header
                  const SearchHeader(),
                  
                  // Filters (if shown)
                  if (_showFilters) const SearchFiltersWidget(),
                  
                  // Active Filters
                  const ActiveFilters(),
                ],
              ),
            ),
            
            // Job List
            const Expanded(child: JobList()),
          ],
        ),
      ),
    );
  }
}