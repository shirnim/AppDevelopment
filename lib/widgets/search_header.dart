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
  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    _searchFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Text
          Text(
            'Find Your Dream Job',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Discover opportunities with AI-powered insights',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 24),
          
          // Search Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Main Search Input
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Job title, keywords, or company...',
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.search_rounded,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: AppTheme.textTertiary,
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) => setState(() {}),
                    onSubmitted: (value) => _performSearch(),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Location and Search Button Row
                Row(
                  children: [
                    // Location Input
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: TextField(
                          controller: _locationController,
                          focusNode: _locationFocusNode,
                          decoration: InputDecoration(
                            hintText: 'City, state, or remote',
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.textTertiary,
                                size: 20,
                              ),
                            ),
                            suffixIcon: _locationController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _locationController.clear();
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      color: AppTheme.textTertiary,
                                      size: 18,
                                    ),
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) => setState(() {}),
                          onSubmitted: (value) => _performSearch(),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Search Button
                    Expanded(
                      child: Consumer<JobProvider>(
                        builder: (context, provider, child) {
                          return Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: provider.isLoading ? null : _performSearch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: provider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.search_rounded,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Search',
                                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                
                // Quick Actions
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Remote Jobs',
                        Icons.home_work_outlined,
                        () => _quickSearch('remote'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Full-time',
                        Icons.work_outline_rounded,
                        () => _quickSearch('full time'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Tech Jobs',
                        Icons.computer_outlined,
                        () => _quickSearch('software engineer'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _quickSearch(String query) {
    _searchController.text = query;
    _performSearch();
  }

  void _performSearch() {
    // Dismiss keyboard
    _searchFocusNode.unfocus();
    _locationFocusNode.unfocus();
    
    if (_searchController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Please enter a search term'),
            ],
          ),
          backgroundColor: AppTheme.warningColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(16),
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
    
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.search_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Text('Searching for "${_searchController.text.trim()}"...'),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}