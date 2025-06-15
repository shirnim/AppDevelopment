import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';
import 'package:job_finder_pro/utils/theme.dart';

class ActiveFilters extends StatelessWidget {
  const ActiveFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        final filters = provider.filters;
        
        if (!filters.hasActiveFilters) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppTheme.surfaceColor,
            border: Border(
              bottom: BorderSide(color: AppTheme.dividerColor),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.filter_list_rounded,
                    color: AppTheme.primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Active Filters',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      provider.clearSearch();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: const Text('Clear All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (filters.location.isNotEmpty)
                    _buildFilterChip(
                      context,
                      Icons.location_on_outlined,
                      filters.location,
                      () => _removeLocationFilter(context),
                    ),
                  if (filters.jobType.isNotEmpty)
                    _buildFilterChip(
                      context,
                      Icons.work_outline_rounded,
                      _getJobTypeLabel(filters.jobType),
                      () => _removeJobTypeFilter(context),
                    ),
                  if (filters.experienceLevel.isNotEmpty)
                    _buildFilterChip(
                      context,
                      Icons.school_outlined,
                      _getExperienceLevelLabel(filters.experienceLevel),
                      () => _removeExperienceLevelFilter(context),
                    ),
                  if (filters.datePosted.isNotEmpty)
                    _buildFilterChip(
                      context,
                      Icons.schedule_rounded,
                      _getDatePostedLabel(filters.datePosted),
                      () => _removeDatePostedFilter(context),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onRemove,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close_rounded,
              color: AppTheme.primaryColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _removeLocationFilter(BuildContext context) {
    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(location: '');
    provider.updateFilters(filters);
  }

  void _removeJobTypeFilter(BuildContext context) {
    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(jobType: '');
    provider.updateFilters(filters);
  }

  void _removeExperienceLevelFilter(BuildContext context) {
    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(experienceLevel: '');
    provider.updateFilters(filters);
  }

  void _removeDatePostedFilter(BuildContext context) {
    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(datePosted: '');
    provider.updateFilters(filters);
  }

  String _getJobTypeLabel(String jobType) {
    switch (jobType) {
      case 'FULLTIME':
        return 'Full-time';
      case 'PARTTIME':
        return 'Part-time';
      case 'CONTRACTOR':
        return 'Contract';
      case 'INTERN':
        return 'Internship';
      default:
        return jobType;
    }
  }

  String _getExperienceLevelLabel(String experienceLevel) {
    switch (experienceLevel) {
      case 'under_3_years_experience':
        return 'Entry Level';
      case 'more_than_3_years_experience':
        return 'Mid Level';
      case 'senior_level':
        return 'Senior Level';
      default:
        return experienceLevel;
    }
  }

  String _getDatePostedLabel(String datePosted) {
    switch (datePosted) {
      case 'today':
        return 'Today';
      case '3days':
        return 'Last 3 days';
      case 'week':
        return 'Last week';
      case 'month':
        return 'Last month';
      default:
        return datePosted;
    }
  }
}