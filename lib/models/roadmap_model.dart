// lib/models/roadmap_model.dart
class RoadmapModel {
  final String id;
  final String field;
  final String grade;
  final String iconName;
  final List<JobOpportunity> jobs;

  RoadmapModel({
    required this.id,
    required this.field,
    required this.grade,
    required this.iconName,
    required this.jobs,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      id: json['id'] ?? '',
      field: json['field'] ?? '',
      grade: json['grade'] ?? '',
      iconName: json['iconName'] ?? 'school',
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((job) => JobOpportunity.fromJson(job))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'grade': grade,
      'iconName': iconName,
      'jobs': jobs.map((job) => job.toJson()).toList(),
    };
  }
}

class JobOpportunity {
  final String id;
  final String title;
  final String salaryRange;
  final String description;
  final List<String> requiredSkills;
  final String experienceLevel;
  final String category;

  JobOpportunity({
    required this.id,
    required this.title,
    required this.salaryRange,
    this.description = '',
    this.requiredSkills = const [],
    this.experienceLevel = 'Entry Level',
    this.category = 'Technology',
  });

  factory JobOpportunity.fromJson(Map<String, dynamic> json) {
    return JobOpportunity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      salaryRange: json['salaryRange'] ?? '',
      description: json['description'] ?? '',
      requiredSkills: List<String>.from(json['requiredSkills'] ?? []),
      experienceLevel: json['experienceLevel'] ?? 'Entry Level',
      category: json['category'] ?? 'Technology',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'salaryRange': salaryRange,
      'description': description,
      'requiredSkills': requiredSkills,
      'experienceLevel': experienceLevel,
      'category': category,
    };
  }

  // Helper method to format salary for display
  String get formattedSalary => '₹ $salaryRange / month';
}