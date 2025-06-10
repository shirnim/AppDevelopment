import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:job_finder_pro/models/job.dart';
import 'package:job_finder_pro/utils/theme.dart';
import 'package:job_finder_pro/widgets/insight_chips.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          if (job.jobApplyLink != null)
            IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () => _launchUrl(job.jobApplyLink!),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobHeader(context),
            _buildInsightsSection(context),
            _buildJobDetails(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildApplyButton(context),
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.jobTitle ?? 'Job Title Not Available',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.business,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  job.employerName ?? 'Company Name Not Available',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildMetaInfo(context),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
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
        if (job.jobSalary != null)
          _buildMetaItem(
            context,
            Icons.attach_money,
            job.jobSalary!,
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
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildInsightsSection(BuildContext context) {
    if (job.keyResponsibilities.isEmpty && job.keyQualifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.05),
            AppTheme.successColor.withOpacity(0.05),
          ],
        ),
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
              Icon(
                Icons.psychology,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'AI-Powered Job Insights',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (job.keyResponsibilities.isNotEmpty) ...[
            InsightChips(
              title: 'Key Responsibilities',
              icon: Icons.task_alt,
              insights: job.keyResponsibilities,
            ),
            const SizedBox(height: 12),
          ],
          if (job.keyQualifications.isNotEmpty)
            InsightChips(
              title: 'Key Qualifications',
              icon: Icons.school,
              insights: job.keyQualifications,
            ),
        ],
      ),
    );
  }

  Widget _buildJobDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job.jobHighlights?.responsibilities.isNotEmpty == true)
            _buildSection(
              context,
              'Key Responsibilities',
              Icons.task_alt,
              job.jobHighlights!.responsibilities,
            ),
          
          if (job.jobHighlights?.qualifications.isNotEmpty == true)
            _buildSection(
              context,
              'Required Qualifications',
              Icons.school,
              job.jobHighlights!.qualifications,
            ),
          
          if (job.jobHighlights?.benefits.isNotEmpty == true)
            _buildSection(
              context,
              'Benefits & Perks',
              Icons.card_giftcard,
              job.jobHighlights!.benefits,
            ),
          
          if (job.jobDescription != null)
            _buildDescriptionSection(context),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<String> items,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
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
                  size: 20,
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
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Full Job Description',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Text(
                job.jobDescription!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    if (job.jobApplyLink == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                'Application link not available',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => _launchUrl(job.jobApplyLink!),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.successColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.open_in_new, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Apply Now',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
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