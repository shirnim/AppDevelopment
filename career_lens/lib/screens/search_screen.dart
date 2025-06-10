import 'package:flutter/material.dart';
import 'package:job_finder_pro/widgets/search_header.dart';
import 'package:job_finder_pro/widgets/job_list.dart';
import 'package:job_finder_pro/widgets/search_filters.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.work,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'JobFinder Pro',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchHeader(),
          if (_showFilters) const SearchFiltersWidget(),
          const Expanded(child: JobList()),
        ],
      ),
    );
  }
}