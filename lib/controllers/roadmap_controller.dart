import 'package:flutter/material.dart';
import '../models/roadmap_model.dart';

class RoadmapController extends ChangeNotifier {
  RoadmapModel? _currentRoadmap;
  bool _isLoading = false;
  String? _errorMessage;
  List<RoadmapModel> _availableRoadmaps = [];

  // Getters
  RoadmapModel? get currentRoadmap => _currentRoadmap;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<RoadmapModel> get availableRoadmaps => _availableRoadmaps;

  // Load roadmap data based on stream
  Future<void> loadRoadmapByStream(String stream) async {
    if (_isLoading && _currentRoadmap?.field == stream) return;
    
    _isLoading = true;
    _errorMessage = null;
    
    Future.microtask(() => notifyListeners());

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Load roadmap based on stream
      _currentRoadmap = _getStreamRoadmap(stream);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load roadmap: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load roadmap data
  Future<void> loadRoadmap(String roadmapId) async {
    if (_isLoading && _currentRoadmap?.id == roadmapId) return;
    
    _isLoading = true;
    _errorMessage = null;
    
    Future.microtask(() => notifyListeners());

    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentRoadmap = _getMockRoadmap(roadmapId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load roadmap: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load available roadmaps
  Future<void> loadAvailableRoadmaps() async {
    _isLoading = true;
    _errorMessage = null;
    Future.microtask(() => notifyListeners());

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _availableRoadmaps = _getMockRoadmaps();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load roadmaps: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Navigate to job details
  void selectJob(JobOpportunity job) {
    debugPrint('Selected job: ${job.title}');
  }

  // Get stream-specific roadmap with colleges
  RoadmapModel _getStreamRoadmap(String stream) {
    switch (stream) {
      case 'Science':
        return RoadmapModel(
          id: 'science_roadmap',
          field: 'Science',
          grade: '12th Grade',
          iconName: 'science',
          roadmapSteps: _getScienceRoadmapSteps(),
          suggestedColleges: _getScienceColleges(),
          jobs: _getScienceJobs(),
        );
      case 'Commerce':
        return RoadmapModel(
          id: 'commerce_roadmap',
          field: 'Commerce',
          grade: '12th Grade',
          iconName: 'business',
          roadmapSteps: _getCommerceRoadmapSteps(),
          suggestedColleges: _getCommerceColleges(),
          jobs: _getCommerceJobs(),
        );
      case 'Arts':
        return RoadmapModel(
          id: 'arts_roadmap',
          field: 'Arts',
          grade: '12th Grade',
          iconName: 'palette',
          roadmapSteps: _getArtsRoadmapSteps(),
          suggestedColleges: _getArtsColleges(),
          jobs: _getArtsJobs(),
        );
      case 'Vocational':
        return RoadmapModel(
          id: 'vocational_roadmap',
          field: 'Vocational',
          grade: '12th Grade',
          iconName: 'build',
          roadmapSteps: _getVocationalRoadmapSteps(),
          suggestedColleges: _getVocationalColleges(),
          jobs: _getVocationalJobs(),
        );
      default:
        return _getStreamRoadmap('Science');
    }
  }

  // Science Stream Data
  List<RoadmapStep> _getScienceRoadmapSteps() {
    return [
      RoadmapStep(
        id: 'sci_step1',
        title: 'Complete 12th Grade (PCM/PCB)',
        description: 'Focus on Physics, Chemistry, Mathematics/Biology with strong foundation',
        stepNumber: 1,
        duration: '2 Years',
        keyPoints: ['Maintain 85%+ marks', 'Prepare for competitive exams', 'Choose specialization'],
        iconName: 'school',
      ),
      RoadmapStep(
        id: 'sci_step2',
        title: 'Entrance Exam Preparation',
        description: 'Prepare for JEE Main/Advanced, NEET, or state-level engineering/medical exams',
        stepNumber: 2,
        duration: '1-2 Years',
        keyPoints: ['Join coaching classes', 'Practice mock tests', 'Time management'],
        iconName: 'quiz',
      ),
      RoadmapStep(
        id: 'sci_step3',
        title: 'Pursue Bachelor\'s Degree',
        description: 'Get admission in engineering, medicine, or pure science programs',
        stepNumber: 3,
        duration: '3-4 Years',
        keyPoints: ['Choose specialization', 'Internships', 'Projects & research'],
        iconName: 'school',
      ),
      RoadmapStep(
        id: 'sci_step4',
        title: 'Career Specialization',
        description: 'Pursue higher education or start professional career',
        stepNumber: 4,
        duration: '2+ Years',
        keyPoints: ['Master\'s degree', 'Industry experience', 'Professional certifications'],
        iconName: 'work',
      ),
    ];
  }

  List<College> _getScienceColleges() {
    return [
      College(
        id: 'nit_srinagar',
        name: 'National Institute of Technology, Srinagar',
        description: 'Premier technical institute offering engineering programs with excellent placement record',
        location: 'Hazratbal, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1960',
        courses: ['Computer Science', 'Electrical Engineering', 'Mechanical Engineering', 'Civil Engineering'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Low fees with scholarship opportunities', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Highly qualified and experienced professors', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'NIT status with national recognition', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Modern labs and research facilities', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Well connected by road and public transport', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'kashmir_university',
        name: 'University of Kashmir',
        description: 'State university with strong science programs and research opportunities',
        location: 'Hazratbal, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1948',
        courses: ['Physics', 'Chemistry', 'Mathematics', 'Biology', 'Environmental Science'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Subsidized fees for local students', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Renowned professors and researchers', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'A+ NAAC accreditation', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Well-equipped science labs', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Local university with hostel facilities', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'gmc_srinagar',
        name: 'Government Medical College, Srinagar',
        description: 'Leading medical college in Kashmir with excellent clinical training',
        location: 'Karan Nagar, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1954',
        courses: ['MBBS', 'MD/MS Specializations', 'Nursing', 'Paramedical'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Government college with minimal fees', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Experienced doctors and medical professionals', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'MCI approved with good NEET rankings', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Associated with SMHS Hospital', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Central location in Srinagar', iconName: 'location_on'),
        ],
      ),
    ];
  }

  List<JobOpportunity> _getScienceJobs() {
    return [
      JobOpportunity(
        id: 'software_engineer',
        title: 'Software Engineer',
        salaryRange: '25,000 - 80,000',
        description: 'Develop software applications and systems',
        requiredSkills: ['Programming', 'Problem Solving', 'Algorithms'],
        experienceLevel: 'Entry to Senior',
        category: 'Technology',
      ),
      JobOpportunity(
        id: 'doctor',
        title: 'Medical Doctor',
        salaryRange: '50,000 - 200,000',
        description: 'Diagnose and treat patients in healthcare settings',
        requiredSkills: ['Medical Knowledge', 'Patient Care', 'Communication'],
        experienceLevel: 'Professional',
        category: 'Healthcare',
      ),
      JobOpportunity(
        id: 'research_scientist',
        title: 'Research Scientist',
        salaryRange: '30,000 - 100,000',
        description: 'Conduct research in specialized scientific fields',
        requiredSkills: ['Research Methods', 'Data Analysis', 'Scientific Writing'],
        experienceLevel: 'Mid to Senior',
        category: 'Research',
      ),
    ];
  }

  // Commerce Stream Data
  List<RoadmapStep> _getCommerceRoadmapSteps() {
    return [
      RoadmapStep(
        id: 'com_step1',
        title: 'Complete 12th Grade Commerce',
        description: 'Focus on Accountancy, Business Studies, Economics, and Mathematics',
        stepNumber: 1,
        duration: '2 Years',
        keyPoints: ['Master accounting principles', 'Understand business concepts', 'Strong in mathematics'],
        iconName: 'business',
      ),
      RoadmapStep(
        id: 'com_step2',
        title: 'Professional Course Entrance',
        description: 'Prepare for CA, CS, CMA foundation or university entrance exams',
        stepNumber: 2,
        duration: '1 Year',
        keyPoints: ['Choose professional path', 'Entrance exam preparation', 'Foundation courses'],
        iconName: 'quiz',
      ),
      RoadmapStep(
        id: 'com_step3',
        title: 'Bachelor\'s Degree + Professional',
        description: 'Pursue B.Com/BBA alongside professional courses like CA/CS',
        stepNumber: 3,
        duration: '3-4 Years',
        keyPoints: ['Dual qualification', 'Practical training', 'Industry exposure'],
        iconName: 'school',
      ),
      RoadmapStep(
        id: 'com_step4',
        title: 'Career Development',
        description: 'Start professional career or pursue advanced qualifications',
        stepNumber: 4,
        duration: '2+ Years',
        keyPoints: ['Professional practice', 'MBA/specialized courses', 'Entrepreneurship'],
        iconName: 'work',
      ),
    ];
  }

  List<College> _getCommerceColleges() {
    return [
      College(
        id: 'kashmir_university_commerce',
        name: 'University of Kashmir - Commerce Department',
        description: 'Well-established commerce department with strong industry connections',
        location: 'Hazratbal, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1948',
        courses: ['B.Com', 'BBA', 'M.Com', 'MBA', 'Economic Studies'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Government fees with financial aid', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Industry experts and qualified professors', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'UGC recognized with good placement record', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Modern commerce labs and library', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Easy access with hostel facilities', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'govt_college_commerce',
        name: 'Government College for Women, Srinagar',
        description: 'Dedicated institution for women\'s higher education in commerce',
        location: 'M.A. Road, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1962',
        courses: ['B.Com', 'M.Com', 'BBA', 'Computer Applications'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Highly subsidized education costs', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Dedicated women faculty members', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'Strong academic record and results', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Women-friendly campus environment', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Central Srinagar location', iconName: 'location_on'),
        ],
      ),
    ];
  }

  List<JobOpportunity> _getCommerceJobs() {
    return [
      JobOpportunity(
        id: 'chartered_accountant',
        title: 'Chartered Accountant',
        salaryRange: '40,000 - 150,000',
        description: 'Handle financial planning, auditing, and taxation',
        requiredSkills: ['Accounting', 'Taxation', 'Financial Analysis'],
        experienceLevel: 'Professional',
        category: 'Finance',
      ),
      JobOpportunity(
        id: 'business_analyst',
        title: 'Business Analyst',
        salaryRange: '30,000 - 80,000',
        description: 'Analyze business processes and recommend improvements',
        requiredSkills: ['Business Analysis', 'Data Analysis', 'Communication'],
        experienceLevel: 'Mid Level',
        category: 'Business',
      ),
      JobOpportunity(
        id: 'bank_manager',
        title: 'Bank Manager',
        salaryRange: '45,000 - 120,000',
        description: 'Manage banking operations and customer relationships',
        requiredSkills: ['Banking', 'Leadership', 'Customer Service'],
        experienceLevel: 'Senior Level',
        category: 'Banking',
      ),
    ];
  }

  // Arts Stream Data
  List<RoadmapStep> _getArtsRoadmapSteps() {
    return [
      RoadmapStep(
        id: 'arts_step1',
        title: 'Complete 12th Grade Arts',
        description: 'Focus on History, Political Science, Psychology, Sociology, or Literature',
        stepNumber: 1,
        duration: '2 Years',
        keyPoints: ['Develop writing skills', 'Critical thinking', 'Choose specialization'],
        iconName: 'palette',
      ),
      RoadmapStep(
        id: 'arts_step2',
        title: 'University Entrance Preparation',
        description: 'Prepare for university entrance exams and competitive exams',
        stepNumber: 2,
        duration: '1 Year',
        keyPoints: ['General knowledge', 'Essay writing', 'Current affairs'],
        iconName: 'quiz',
      ),
      RoadmapStep(
        id: 'arts_step3',
        title: 'Bachelor\'s Degree',
        description: 'Pursue BA in chosen subjects with focus on skill development',
        stepNumber: 3,
        duration: '3 Years',
        keyPoints: ['Subject expertise', 'Research projects', 'Communication skills'],
        iconName: 'school',
      ),
      RoadmapStep(
        id: 'arts_step4',
        title: 'Career Specialization',
        description: 'Pursue higher studies or professional development',
        stepNumber: 4,
        duration: '2+ Years',
        keyPoints: ['Master\'s degree', 'Professional courses', 'Skill certifications'],
        iconName: 'work',
      ),
    ];
  }

  List<College> _getArtsColleges() {
    return [
      College(
        id: 'kashmir_university_arts',
        name: 'University of Kashmir - Arts Faculty',
        description: 'Comprehensive arts education with diverse subject offerings',
        location: 'Hazratbal, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1948',
        courses: ['Political Science', 'History', 'Psychology', 'Sociology', 'English', 'Urdu'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Low cost quality education', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Subject matter experts and researchers', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'Prestigious university with good alumni', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Libraries and research facilities', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Public transport connectivity', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'degree_college_baramulla',
        name: 'Degree College Baramulla',
        description: 'Government college offering quality arts education in North Kashmir',
        location: 'Baramulla, Kashmir',
        type: 'Government',
        establishedYear: '1965',
        courses: ['BA General', 'BA Honours', 'Social Work', 'Mass Communication'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Government college with minimal fees', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Local and qualified teaching staff', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'Good results and academic record', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Basic but adequate facilities', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Serves North Kashmir region', iconName: 'location_on'),
        ],
      ),
    ];
  }

  List<JobOpportunity> _getArtsJobs() {
    return [
      JobOpportunity(
        id: 'civil_services',
        title: 'Civil Services Officer',
        salaryRange: '56,000 - 250,000',
        description: 'Administrative roles in government departments',
        requiredSkills: ['Public Administration', 'Leadership', 'Policy Analysis'],
        experienceLevel: 'Professional',
        category: 'Government',
      ),
      JobOpportunity(
        id: 'journalist',
        title: 'Journalist/Reporter',
        salaryRange: '20,000 - 60,000',
        description: 'Report news and write articles for media outlets',
        requiredSkills: ['Writing', 'Research', 'Communication'],
        experienceLevel: 'Entry to Senior',
        category: 'Media',
      ),
      JobOpportunity(
        id: 'teacher',
        title: 'Teacher/Professor',
        salaryRange: '25,000 - 80,000',
        description: 'Teach students in schools, colleges, or universities',
        requiredSkills: ['Subject Knowledge', 'Teaching', 'Patience'],
        experienceLevel: 'Entry to Senior',
        category: 'Education',
      ),
    ];
  }

  // Vocational Stream Data
  List<RoadmapStep> _getVocationalRoadmapSteps() {
    return [
      RoadmapStep(
        id: 'voc_step1',
        title: 'Complete 12th Grade Vocational',
        description: 'Focus on practical skills and vocational subjects',
        stepNumber: 1,
        duration: '2 Years',
        keyPoints: ['Hands-on training', 'Technical skills', 'Industry exposure'],
        iconName: 'build',
      ),
      RoadmapStep(
        id: 'voc_step2',
        title: 'Skill Certification',
        description: 'Get certified in chosen vocational skills',
        stepNumber: 2,
        duration: '6 Months - 1 Year',
        keyPoints: ['Industry certifications', 'Practical training', 'Portfolio building'],
        iconName: 'verified',
      ),
      RoadmapStep(
        id: 'voc_step3',
        title: 'Diploma/Professional Course',
        description: 'Pursue diploma or professional courses in specialized areas',
        stepNumber: 3,
        duration: '1-2 Years',
        keyPoints: ['Specialization', 'Advanced skills', 'Industry connections'],
        iconName: 'school',
      ),
      RoadmapStep(
        id: 'voc_step4',
        title: 'Career Entry & Growth',
        description: 'Start professional career with continuous skill upgrades',
        stepNumber: 4,
        duration: 'Ongoing',
        keyPoints: ['Job placement', 'Skill updates', 'Career advancement'],
        iconName: 'work',
      ),
    ];
  }

  List<College> _getVocationalColleges() {
    return [
      College(
        id: 'iti_srinagar',
        name: 'Industrial Training Institute (ITI), Srinagar',
        description: 'Government ITI offering practical training in various trades',
        location: 'Bemina, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1962',
        courses: ['Electrician', 'Fitter', 'Welder', 'Computer Operator', 'Motor Mechanic'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Very low fees with stipend during training', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Industry experienced instructors', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'Government recognized certificates', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Modern workshops and equipment', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Multiple ITI centers across Kashmir', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'polytechnic_srinagar',
        name: 'Government Polytechnic, Srinagar',
        description: 'Technical education institute offering diploma programs',
        location: 'Zakura, Srinagar, Kashmir',
        type: 'Government',
        establishedYear: '1958',
        courses: ['Civil Engineering', 'Mechanical Engineering', 'Electrical Engineering', 'Computer Science'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Government diploma with low fees', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Technical experts and industry professionals', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'AICTE approved with good placements', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Well-equipped technical labs', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Regular transport facilities', iconName: 'location_on'),
        ],
      ),
      College(
        id: 'skill_development_kashmir',
        name: 'Kashmir Skill Development Centre',
        description: 'Modern skill development center with industry partnerships',
        location: 'Various locations across Kashmir',
        type: 'Government',
        establishedYear: '2015',
        courses: ['Digital Marketing', 'Web Development', 'Hospitality', 'Handicrafts', 'Tourism'],
        pros: [
          CollegePro(title: 'Affordability', description: 'Free training with placement assistance', iconName: 'monetization_on'),
          CollegePro(title: 'Faculty', description: 'Industry trainers and mentors', iconName: 'people'),
          CollegePro(title: 'Reputation', description: 'Government initiative with industry tie-ups', iconName: 'star'),
          CollegePro(title: 'Infrastructure', description: 'Modern training facilities', iconName: 'domain'),
          CollegePro(title: 'Accessibility', description: 'Multiple centers across districts', iconName: 'location_on'),
        ],
      ),
    ];
  }

  List<JobOpportunity> _getVocationalJobs() {
    return [
      JobOpportunity(
        id: 'electrician',
        title: 'Electrician',
        salaryRange: '18,000 - 45,000',
        description: 'Install and maintain electrical systems',
        requiredSkills: ['Electrical Knowledge', 'Safety Protocols', 'Problem Solving'],
        experienceLevel: 'Entry to Senior',
        category: 'Technical',
      ),
      JobOpportunity(
        id: 'web_developer',
        title: 'Web Developer',
        salaryRange: '20,000 - 60,000',
        description: 'Create and maintain websites and web applications',
        requiredSkills: ['HTML/CSS', 'JavaScript', 'Web Design'],
        experienceLevel: 'Entry to Mid',
        category: 'Technology',
      ),
      JobOpportunity(
        id: 'chef',
        title: 'Professional Chef',
        salaryRange: '15,000 - 50,000',
        description: 'Prepare food in restaurants, hotels, or catering services',
        requiredSkills: ['Cooking', 'Food Safety', 'Creativity'],
        experienceLevel: 'Entry to Senior',
        category: 'Hospitality',
      ),
    ];
  }

  // Existing methods remain the same...
  RoadmapModel _getMockRoadmap(String roadmapId) {
    if (roadmapId == 'software_engineer') {
      return RoadmapModel(
        id: 'software_engineer',
        field: 'Software Engineering',
        grade: 'All Levels',
        iconName: 'code',
        jobs: [
          JobOpportunity(
            id: 'se1',
            title: 'Frontend Developer',
            salaryRange: '40,000 - 80,000',
            description: 'Build user interfaces and implement client-side logic',
            requiredSkills: ['HTML', 'CSS', 'JavaScript', 'React', 'UI/UX'],
            experienceLevel: 'Entry to Senior',
            category: 'Technology',
          ),
          JobOpportunity(
            id: 'se2',
            title: 'Backend Developer',
            salaryRange: '45,000 - 90,000',
            description: 'Develop server-side logic and database architecture',
            requiredSkills: ['Node.js', 'Python', 'Java', 'SQL', 'APIs'],
            experienceLevel: 'Mid to Senior',
            category: 'Technology',
          ),
          JobOpportunity(
            id: 'se3',
            title: 'Full Stack Developer',
            salaryRange: '50,000 - 100,000',
            description: 'Work on both frontend and backend development',
            requiredSkills: ['JavaScript', 'React', 'Node.js', 'Databases', 'APIs'],
            experienceLevel: 'Mid to Senior',
            category: 'Technology',
          ),
        ],
      );
    }
    
    return RoadmapModel(
      id: 'science_12th',
      field: 'Science',
      grade: '12th Grade',
      iconName: 'school',
      jobs: [
        JobOpportunity(
          id: '1',
          title: 'Software Engineer',
          salaryRange: '30,000 - 50,000',
          description: 'Develop and maintain software applications',
          requiredSkills: ['Programming', 'Problem Solving', 'Teamwork'],
          experienceLevel: 'Entry Level',
          category: 'Technology',
        ),
        JobOpportunity(
          id: '2',
          title: 'Data Analyst',
          salaryRange: '25,000 - 40,000',
          description: 'Analyze data to help businesses make decisions',
          requiredSkills: ['Statistics', 'Excel', 'SQL', 'Python'],
          experienceLevel: 'Entry Level',
          category: 'Analytics',
        ),
        JobOpportunity(
          id: '3',
          title: 'Biomedical Engineer',
          salaryRange: '35,000 - 60,000',
          description: 'Design medical equipment and devices',
          requiredSkills: ['Biology', 'Engineering', 'Problem Solving'],
          experienceLevel: 'Entry Level',
          category: 'Healthcare',
        ),
        JobOpportunity(
          id: '4',
          title: 'Lab Technician',
          salaryRange: '20,000 - 35,000',
          description: 'Conduct laboratory tests and experiments',
          requiredSkills: ['Lab Safety', 'Attention to Detail', 'Chemistry'],
          experienceLevel: 'Entry Level',
          category: 'Healthcare',
        ),
      ],
    );
  }

  List<RoadmapModel> _getMockRoadmaps() {
    return [
      RoadmapModel(
        id: 'science_12th',
        field: 'Science',
        grade: '12th Grade',
        iconName: 'school',
        jobs: [],
      ),
      RoadmapModel(
        id: 'commerce_12th',
        field: 'Commerce',
        grade: '12th Grade',
        iconName: 'business',
        jobs: [],
      ),
      RoadmapModel(
        id: 'arts_12th',
        field: 'Arts',
        grade: '12th Grade',
        iconName: 'palette',
        jobs: [],
      ),
    ];
  }

  // Get icon based on icon name
  IconData getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'school':
        return Icons.school;
      case 'business':
        return Icons.business;
      case 'palette':
        return Icons.palette;
      case 'computer':
        return Icons.computer;
      case 'science':
        return Icons.science;
      case 'engineering':
        return Icons.engineering;
      case 'medical':
        return Icons.medical_services;
      case 'analytics':
        return Icons.analytics;
      case 'build':
        return Icons.build;
      case 'work':
        return Icons.work;
      case 'quiz':
        return Icons.quiz;
      case 'verified':
        return Icons.verified;
      case 'check_circle':
        return Icons.check_circle;
      case 'monetization_on':
        return Icons.monetization_on;
      case 'people':
        return Icons.people;
      case 'star':
        return Icons.star;
      case 'domain':
        return Icons.domain;
      case 'location_on':
        return Icons.location_on;
      default:
        return Icons.school;
    }
  }
}