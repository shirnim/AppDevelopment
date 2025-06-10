import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Filters',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  'Job Type',
                  _jobType,
                  [
                    const DropdownMenuItem(value: '', child: Text('All Types')),
                    const DropdownMenuItem(value: 'FULLTIME', child: Text('Full-time')),
                    const DropdownMenuItem(value: 'PARTTIME', child: Text('Part-time')),
                    const DropdownMenuItem(value: 'CONTRACTOR', child: Text('Contract')),
                    const DropdownMenuItem(value: 'INTERN', child: Text('Internship')),
                  ],
                  (value) {
                    setState(() {
                      _jobType = value!;
                    });
                    _updateFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  'Experience',
                  _experienceLevel,
                  [
                    const DropdownMenuItem(value: '', child: Text('All Levels')),
                    const DropdownMenuItem(value: 'under_3_years_experience', child: Text('Entry Level')),
                    const DropdownMenuItem(value: 'more_than_3_years_experience', child: Text('Mid Level')),
                    const DropdownMenuItem(value: 'senior_level', child: Text('Senior Level')),
                  ],
                  (value) {
                    setState(() {
                      _experienceLevel = value!;
                    });
                    _updateFilters();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            'Date Posted',
            _datePosted,
            [
              const DropdownMenuItem(value: '', child: Text('Any Time')),
              const DropdownMenuItem(value: 'today', child: Text('Today')),
              const DropdownMenuItem(value: '3days', child: Text('Last 3 days')),
              const DropdownMenuItem(value: 'week', child: Text('Last week')),
              const DropdownMenuItem(value: 'month', child: Text('Last month')),
            ],
            (value) {
              setState(() {
                _datePosted = value!;
              });
              _updateFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(
    String label,
    T value,
    List<DropdownMenuItem<T>> items,
    void Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
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
}