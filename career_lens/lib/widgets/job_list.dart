import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';
import 'package:job_finder_pro/widgets/job_card.dart';
import 'package:job_finder_pro/widgets/active_filters.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<JobProvider>().loadMoreJobs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading jobs',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  provider.error!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.searchJobs(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.jobs.isEmpty && !provider.isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No jobs found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Try adjusting your search criteria',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            if (provider.filters.hasActiveFilters) const ActiveFilters(),
            if (provider.jobs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${provider.totalJobs} jobs found',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: provider.jobs.length + (provider.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= provider.jobs.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return JobCard(job: provider.jobs[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}