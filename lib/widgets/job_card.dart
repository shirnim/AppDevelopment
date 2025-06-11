import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:job_finder_pro/models/job.dart';
import 'package:job_finder_pro/screens/job_detail_screen.dart';
import 'package:job_finder_pro/utils/theme.dart';
import 'package:job_finder_pro/widgets/insight_chips.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToJobDetail(context),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJobHeader(context),
                const SizedBox(height: 16),
                _buildJobMeta(context),
                if (job.keyResponsibilities.isNotEmpty ||
                    job.keyQualifications.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildInsights(context),
                ],
                const SizedBox(height: 20),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Logo
        _buildCompanyLogo(),
        
        const SizedBox(width: 16),
        
        // Job Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.jobTitle ?? 'No Title',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                job.employerName ?? 'Unknown Company',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        
        // Bookmark Icon
        IconButton(
          onPressed: () {
            // TODO: Implement bookmark functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Bookmark feature coming soon!'),
                backgroundColor: AppTheme.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.bookmark_border_rounded,
            color: AppTheme.textTertiary,
          ),
          style: IconButton.styleFrom(
            backgroundColor: AppTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyLogo() {
    // Try to load company logo from assets or use placeholder
    final companyName = job.employerName?.toLowerCase().replaceAll(' ', '_') ?? 'default';
    final logoPath = 'assets/images/companies/$companyName.png';
    
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.asset(
          logoPath,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to icon if image not found
            return Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                Icons.business_rounded,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            );
          },
        ),
      ),
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
            Icons.location_on_outlined,
            job.jobLocation!,
          ),
        if (job.jobEmploymentType != null)
          _buildMetaItem(
            context,
            Icons.work_outline_rounded,
            job.jobEmploymentType!,
          ),
        if (job.jobPostedAt != null)
          _buildMetaItem(
            context,
            Icons.schedule_rounded,
            _formatDate(job.jobPostedAt!),
          ),
        if (job.jobSalary != null)
          _buildMetaItem(
            context,
            Icons.attach_money_rounded,
            job.jobSalary!,
            color: AppTheme.successColor,
          ),
      ],
    );
  }

  Widget _buildMetaItem(
    BuildContext context, 
    IconData icon, 
    String text, {
    Color? color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color ?? AppTheme.textTertiary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color ?? AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInsights(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.psychology_rounded,
                  color: AppTheme.primaryColor,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'AI Insights',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (job.keyResponsibilities.isNotEmpty)
            InsightChips(
              title: 'Key Responsibilities',
              icon: Icons.task_alt_rounded,
              insights: job.keyResponsibilities.take(3).toList(),
            ),
          if (job.keyResponsibilities.isNotEmpty && job.keyQualifications.isNotEmpty)
            const SizedBox(height: 8),
          if (job.keyQualifications.isNotEmpty)
            InsightChips(
              title: 'Key Qualifications',
              icon: Icons.school_rounded,
              insights: job.keyQualifications.take(3).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _navigateToJobDetail(context),
            icon: const Icon(Icons.visibility_outlined, size: 18),
            label: const Text('View Details'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: AppTheme.primaryColor, width: 1.5),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: job.jobApplyLink != null 
                  ? AppTheme.successGradient 
                  : LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade500]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: job.jobApplyLink != null ? [
                BoxShadow(
                  color: AppTheme.successColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: ElevatedButton.icon(
              onPressed: job.jobApplyLink != null
                  ? () => _launchUrl(job.jobApplyLink!)
                  : null,
              icon: Icon(
                job.jobApplyLink != null 
                    ? Icons.open_in_new_rounded 
                    : Icons.link_off_rounded, 
                size: 18,
                color: Colors.white,
              ),
              label: Text(
                job.jobApplyLink != null ? 'Apply' : 'No Link',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
      } else if (difference < 30) {
        final weeks = (difference / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
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
    } else {
      // Handle error gracefully
      debugPrint('Could not launch $url');
    }
  }
}