import 'package:flutter/material.dart';
import 'package:job_finder_pro/utils/theme.dart';

class AnalyticsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<dynamic> data;
  final Widget Function(dynamic item) itemBuilder;

  const AnalyticsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (data.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No data available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ...data.take(5).map((item) => itemBuilder(item)),
          ],
        ),
      ),
    );
  }
}