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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.more_vert_rounded,
                  color: AppTheme.textTertiary,
                  size: 20,
                ),
              ],
            ),
          ),
          
          // Divider
          const Divider(height: 1),
          
          // Content
          if (data.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme.textTertiary,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No data available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: data.take(5).map((item) => itemBuilder(item)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}