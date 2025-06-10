import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:job_finder_pro/providers/analytics_provider.dart';
import 'package:job_finder_pro/widgets/analytics_card.dart';
import 'package:job_finder_pro/utils/theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().loadAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.analytics,
              color: AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Analytics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<AnalyticsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
                    'Error loading analytics',
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
                    onPressed: () => provider.loadAnalytics(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final data = provider.analyticsData;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Job Market Insights',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                
                if (data['search_trends'] != null)
                  AnalyticsCard(
                    title: 'Popular Search Terms',
                    icon: Icons.trending_up,
                    data: data['search_trends'],
                    itemBuilder: (item) => ListTile(
                      title: Text(item['query']),
                      subtitle: Text('${item['search_count']} searches'),
                      trailing: Text('${item['avg_results']} avg results'),
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                if (data['location_trends'] != null)
                  AnalyticsCard(
                    title: 'Top Job Locations',
                    icon: Icons.location_on,
                    data: data['location_trends'],
                    itemBuilder: (item) => ListTile(
                      title: Text(item['location']),
                      trailing: Text('${item['job_count']} jobs'),
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                if (data['company_trends'] != null)
                  AnalyticsCard(
                    title: 'Top Hiring Companies',
                    icon: Icons.business,
                    data: data['company_trends'],
                    itemBuilder: (item) => ListTile(
                      title: Text(item['company']),
                      trailing: Text('${item['job_count']} jobs'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}