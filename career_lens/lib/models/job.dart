class Job {
  final String? jobId;
  final String? jobTitle;
  final String? employerName;
  final String? jobLocation;
  final String? jobEmploymentType;
  final String? jobPostedAt;
  final String? jobApplyLink;
  final String? jobDescription;
  final String? jobSalary;
  final JobHighlights? jobHighlights;
  final List<String> keyResponsibilities;
  final List<String> keyQualifications;

  Job({
    this.jobId,
    this.jobTitle,
    this.employerName,
    this.jobLocation,
    this.jobEmploymentType,
    this.jobPostedAt,
    this.jobApplyLink,
    this.jobDescription,
    this.jobSalary,
    this.jobHighlights,
    this.keyResponsibilities = const [],
    this.keyQualifications = const [],
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      employerName: json['employer_name'],
      jobLocation: json['job_location'],
      jobEmploymentType: json['job_employment_type'],
      jobPostedAt: json['job_posted_at'],
      jobApplyLink: json['job_apply_link'],
      jobDescription: json['job_description'],
      jobSalary: json['job_salary'],
      jobHighlights: json['job_highlights'] != null
          ? JobHighlights.fromJson(json['job_highlights'])
          : null,
      keyResponsibilities: json['key_responsibilities'] != null
          ? List<String>.from(json['key_responsibilities'])
          : [],
      keyQualifications: json['key_qualifications'] != null
          ? List<String>.from(json['key_qualifications'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'employer_name': employerName,
      'job_location': jobLocation,
      'job_employment_type': jobEmploymentType,
      'job_posted_at': jobPostedAt,
      'job_apply_link': jobApplyLink,
      'job_description': jobDescription,
      'job_salary': jobSalary,
      'job_highlights': jobHighlights?.toJson(),
      'key_responsibilities': keyResponsibilities,
      'key_qualifications': keyQualifications,
    };
  }
}

class JobHighlights {
  final List<String> responsibilities;
  final List<String> qualifications;
  final List<String> benefits;

  JobHighlights({
    this.responsibilities = const [],
    this.qualifications = const [],
    this.benefits = const [],
  });

  factory JobHighlights.fromJson(Map<String, dynamic> json) {
    return JobHighlights(
      responsibilities: json['Responsibilities'] != null
          ? List<String>.from(json['Responsibilities'])
          : [],
      qualifications: json['Qualifications'] != null
          ? List<String>.from(json['Qualifications'])
          : [],
      benefits: json['Benefits'] != null
          ? List<String>.from(json['Benefits'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Responsibilities': responsibilities,
      'Qualifications': qualifications,
      'Benefits': benefits,
    };
  }
}