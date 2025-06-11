import 'package:flutter/material.dart';
import 'package:job_finder_pro/utils/theme.dart';

class InsightChips extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> insights;

  const InsightChips({
    super.key,
    required this.title,
    required this.icon,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.successColor,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: insights.map((insight) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successColor.withOpacity(0.2),
              ),
            ),
            child: Text(
              insight,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.successColor,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}