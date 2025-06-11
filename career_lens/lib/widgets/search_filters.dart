import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';
import 'package:job_finder_pro/utils/theme.dart';

class SearchFiltersWidget extends StatefulWidget {
  const SearchFiltersWidget({super.key});

  @override
  State<SearchFiltersWidget> createState() => _SearchFiltersWidgetState();
}

class _SearchFiltersWidgetState extends State<SearchFiltersWidget> {
  String _jobType = '';
  String _experienceLevel = '';
  String _datePosted = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: AppTheme.primaryColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Advanced Search Filters',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Professional',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Job Type Filter
          _buildFilterSection(
            'Job Type',
            Icons.work_outline_rounded,
            DropdownButtonFormField<String>(
              value: _jobType.isEmpty ? null : _jobType,
              decoration: _getInputDecoration('Select job type'),
              items: const [
                DropdownMenuItem(value: '', child: Text('All Types')),
                DropdownMenuItem(value: 'FULLTIME', child: Text('Full-time')),
                DropdownMenuItem(value: 'PARTTIME', child: Text('Part-time')),
                DropdownMenuItem(value: 'CONTRACTOR', child: Text('Contract')),
                DropdownMenuItem(value: 'INTERN', child: Text('Internship')),
              ],
              onChanged: (value) {
                setState(() {
                  _jobType = value ?? '';
                });
                _updateFilters();
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Experience Level Filter
          _buildFilterSection(
            'Experience Level',
            Icons.school_outlined,
            DropdownButtonFormField<String>(
              value: _experienceLevel.isEmpty ? null : _experienceLevel,
              decoration: _getInputDecoration('Select experience level'),
              items: const [
                DropdownMenuItem(value: '', child: Text('All Levels')),
                DropdownMenuItem(value: 'under_3_years_experience', child: Text('Entry Level')),
                DropdownMenuItem(value: 'more_than_3_years_experience', child: Text('Mid Level')),
                DropdownMenuItem(value: 'senior_level', child: Text('Senior Level')),
              ],
              onChanged: (value) {
                setState(() {
                  _experienceLevel = value ?? '';
                });
                _updateFilters();
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Date Posted Filter
          _buildFilterSection(
            'Date Posted',
            Icons.schedule_rounded,
            DropdownButtonFormField<String>(
              value: _datePosted.isEmpty ? null : _datePosted,
              decoration: _getInputDecoration('Select date range'),
              items: const [
                DropdownMenuItem(value: '', child: Text('Any Time')),
                DropdownMenuItem(value: 'today', child: Text('Today')),
                DropdownMenuItem(value: '3days', child: Text('Last 3 days')),
                DropdownMenuItem(value: 'week', child: Text('Last week')),
                DropdownMenuItem(value: 'month', child: Text('Last month')),
              ],
              onChanged: (value) {
                setState(() {
                  _datePosted = value ?? '';
                });
                _updateFilters();
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Clear Filters Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.clear_rounded),
              label: const Text('Clear All Filters'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, IconData icon, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.textSecondary,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppTheme.surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  void _updateFilters() {
    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(
      jobType: _jobType,
      experienceLevel: _experienceLevel,
      datePosted: _datePosted,
    );
    provider.updateFilters(filters);
  }

  void _clearFilters() {
    setState(() {
      _jobType = '';
      _experienceLevel = '';
      _datePosted = '';
    });
    _updateFilters();
  }
}