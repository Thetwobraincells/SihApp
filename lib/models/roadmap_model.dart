// lib/models/roadmap_model.dart
class RoadmapModel {
  final String id;
  final String field;
  final String grade;
  final String iconName;
  final List<JobOpportunity> jobs;
  final List<RoadmapStep> roadmapSteps;
  final List<College> suggestedColleges;

  RoadmapModel({
    required this.id,
    required this.field,
    required this.grade,
    required this.iconName,
    required this.jobs,
    this.roadmapSteps = const [],
    this.suggestedColleges = const [],
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
      roadmapSteps: (json['roadmapSteps'] as List<dynamic>?)
          ?.map((step) => RoadmapStep.fromJson(step))
          .toList() ?? [],
      suggestedColleges: (json['suggestedColleges'] as List<dynamic>?)
          ?.map((college) => College.fromJson(college))
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
      'roadmapSteps': roadmapSteps.map((step) => step.toJson()).toList(),
      'suggestedColleges': suggestedColleges.map((college) => college.toJson()).toList(),
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

  String get formattedSalary => '₹ $salaryRange / month';
}

class RoadmapStep {
  final String id;
  final String title;
  final String description;
  final int stepNumber;
  final String duration;
  final List<String> keyPoints;
  final String iconName;
  final bool isCompleted;

  RoadmapStep({
    required this.id,
    required this.title,
    required this.description,
    required this.stepNumber,
    this.duration = '',
    this.keyPoints = const [],
    this.iconName = 'school',
    this.isCompleted = false,
  });

  factory RoadmapStep.fromJson(Map<String, dynamic> json) {
    return RoadmapStep(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      stepNumber: json['stepNumber'] ?? 1,
      duration: json['duration'] ?? '',
      keyPoints: List<String>.from(json['keyPoints'] ?? []),
      iconName: json['iconName'] ?? 'school',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'stepNumber': stepNumber,
      'duration': duration,
      'keyPoints': keyPoints,
      'iconName': iconName,
      'isCompleted': isCompleted,
    };
  }
}

class College {
  final String id;
  final String name;
  final String description;
  final String location;
  final List<String> courses;
  final List<CollegePro> pros;
  final String establishedYear;
  final String type; // Government, Private, Autonomous
  final String website;

  College({
    required this.id,
    required this.name,
    required this.description,
    this.location = 'Kashmir, Ghawal District',
    this.courses = const [],
    this.pros = const [],
    this.establishedYear = '',
    this.type = 'Government',
    this.website = '',
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? 'Kashmir, Ghawal District',
      courses: List<String>.from(json['courses'] ?? []),
      pros: (json['pros'] as List<dynamic>?)
          ?.map((pro) => CollegePro.fromJson(pro))
          .toList() ?? [],
      establishedYear: json['establishedYear'] ?? '',
      type: json['type'] ?? 'Government',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'courses': courses,
      'pros': pros.map((pro) => pro.toJson()).toList(),
      'establishedYear': establishedYear,
      'type': type,
      'website': website,
    };
  }
}

class CollegePro {
  final String title;
  final String description;
  final String iconName;

  CollegePro({
    required this.title,
    required this.description,
    this.iconName = 'check_circle',
  });

  factory CollegePro.fromJson(Map<String, dynamic> json) {
    return CollegePro(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      iconName: json['iconName'] ?? 'check_circle',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'iconName': iconName,
    };
  }
}