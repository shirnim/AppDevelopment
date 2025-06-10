import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:job_finder_pro/models/job.dart';
import 'package:job_finder_pro/screens/job_detail_screen.dart';
import 'package:job_finder_pro/utils/theme.dart';
import 'package:job_finder_pro/widgets/insight_chips.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _navigateToJobDetail(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJobHeader(context),
              const SizedBox(height: 12),
              _buildJobMeta(context),
              if (job.keyResponsibilities.isNotEmpty ||
                  job.keyQualifications.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildInsights(context),
              ],
              const SizedBox(height: 16),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.jobTitle ?? 'No Title',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.business,
              color: AppTheme.primaryColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                job.employerName ?? 'Unknown Company',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobMeta(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        if (job.jobLocation != null)
          _buildMetaItem(
            context,
            Icons.location_on,
            job.jobLocation!,
          ),
        if (job.jobEmploymentType != null)
          _buildMetaItem(
            context,
            Icons.work,
            job.jobEmploymentType!,
          ),
        if (job.jobPostedAt != null)
          _buildMetaItem(
            context,
            Icons.calendar_today,
            _formatDate(job.jobPostedAt!),
          ),
      ],
    );
  }

  Widget _buildMetaItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInsights(BuildContext context) {
    return Column(
      children: [
        if (job.keyResponsibilities.isNotEmpty)
          InsightChips(
            title: 'Key Responsibilities',
            icon: Icons.task_alt,
            insights: job.keyResponsibilities.take(3).toList(),
          ),
        if (job.keyResponsibilities.isNotEmpty && job.keyQualifications.isNotEmpty)
          const SizedBox(height: 8),
        if (job.keyQualifications.isNotEmpty)
          InsightChips(
            title: 'Key Qualifications',
            icon: Icons.school,
            insights: job.keyQualifications.take(3).toList(),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _navigateToJobDetail(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility, size: 16),
                SizedBox(width: 4),
                Text('View Details'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: job.jobApplyLink != null
                ? () => _launchUrl(job.jobApplyLink!)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.open_in_new, size: 16, color: Colors.white),
                SizedBox(width: 4),
                Text('Apply', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToJobDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailScreen(job: job),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) {
        return 'Today';
      } else if (difference == 1) {
        return 'Yesterday';
      } else if (difference < 7) {
        return '$difference days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString.substring(0, 10);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}