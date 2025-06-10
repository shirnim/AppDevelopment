import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/job_provider.dart';
import 'package:job_finder_pro/utils/theme.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({super.key});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryDark,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Your Dream Job',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover thousands of opportunities with AI-powered insights',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 24),
              _buildSearchForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for jobs, companies...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Consumer<JobProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      }
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Search Jobs'),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: _clearSearch,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  side: const BorderSide(color: AppTheme.borderColor),
                ),
                child: const Icon(Icons.clear),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    if (_searchController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a search term'),
        ),
      );
      return;
    }

    final provider = context.read<JobProvider>();
    final filters = provider.filters.copyWith(
      query: _searchController.text.trim(),
      location: _locationController.text.trim(),
    );

    provider.updateFilters(filters);
    provider.searchJobs();
  }

  void _clearSearch() {
    _searchController.clear();
    _locationController.clear();
    context.read<JobProvider>().clearSearch();
  }
}