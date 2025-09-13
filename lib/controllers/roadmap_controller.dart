// lib/controllers/roadmap_controller.dart
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

  // Load roadmap data
  Future<void> loadRoadmap(String roadmapId) async {
    // Only update if we're not already loading the same roadmap
    if (_isLoading && _currentRoadmap?.id == roadmapId) return;
    
    _isLoading = true;
    _errorMessage = null;
    
    // Use a microtask to ensure we're not in the build phase
    Future.microtask(() => notifyListeners());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - replace with actual API call
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
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data
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
    // TODO: Navigate to job details screen
    debugPrint('Selected job: ${job.title}');
  }

  // Mock data methods
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
    
    // Default to science_12th if no matching roadmap is found
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
      default:
        return Icons.school;
    }
  }
}