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
              color: AppTheme.primaryColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: insights.map((insight) => Chip(
            label: Text(insight),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          )).toList(),
        ),
      ],
    );
  }
}