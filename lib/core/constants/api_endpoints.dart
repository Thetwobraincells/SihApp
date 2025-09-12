class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.careerguide.com/v1';
  
  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOtp = '/auth/verify-otp';
  
  // User Endpoints
  static const String userProfile = '/users/me';
  static const String updateProfile = '/users/update-profile';
  static const String changePassword = '/users/change-password';
  static const String uploadProfilePicture = '/users/upload-picture';
  
  // Quiz Endpoints
  static const String quizCategories = '/quiz/categories';
  static const String startQuiz = '/quiz/start';
  static const String submitQuiz = '/quiz/submit';
  static const String quizResults = '/quiz/results';
  static const String quizHistory = '/quiz/history';
  
  // College Finder Endpoints
  static const String searchColleges = '/colleges/search';
  static const String collegeDetails = '/colleges/{id}';
  static const String compareColleges = '/colleges/compare';
  static const String recommendedColleges = '/colleges/recommended';
  
  // Roadmap Endpoints
  static const String careerPaths = '/roadmap/career-paths';
  static const String careerPathDetails = '/roadmap/career-paths/{id}';
  static const String createRoadmap = '/roadmap/create';
  static const String updateRoadmap = '/roadmap/{id}/update';
  static const String getRoadmap = '/roadmap/{id}';
  
  // Role Models Endpoints
  static const String roleModels = '/role-models';
  static const String roleModelDetails = '/role-models/{id}';
  static const String bookSession = '/role-models/{id}/book-session';
  
  // Scholarships Endpoints
  static const String scholarships = '/scholarships';
  static const String scholarshipDetails = '/scholarships/{id}';
  static const String applyScholarship = '/scholarships/{id}/apply';
  static const String myApplications = '/scholarships/my-applications';
  
  // Timeline Endpoints
  static const String timelineEvents = '/timeline/events';
  static const String addTimelineEvent = '/timeline/events/add';
  static const String updateTimelineEvent = '/timeline/events/{id}/update';
  static const String deleteTimelineEvent = '/timeline/events/{id}/delete';
  
  // Parent Zone Endpoints
  static const String parentResources = '/parent-zone/resources';
  static const String parentWebinars = '/parent-zone/webinars';
  static const String parentGuides = '/parent-zone/guides';
  
  // Career Switch Endpoints
  static const String careerAssessments = '/career-switch/assessments';
  static const String careerSwitchResources = '/career-switch/resources';
  static const String careerSwitchSuccessStories = '/career-switch/success-stories';
  
  // Content Endpoints
  static const String articles = '/content/articles';
  static const String articleDetails = '/content/articles/{id}';
  static const String videos = '/content/videos';
  static const String videoDetails = '/content/videos/{id}';
  
  // Support Endpoints
  static const String contactSupport = '/support/contact';
  static const String faqs = '/support/faqs';
  static const String submitFeedback = '/support/feedback';
  
  // Helper methods
  static String buildUrl(String endpoint, {Map<String, dynamic>? pathParams}) {
    String url = '$baseUrl$endpoint';
    
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        url = url.replaceAll('{$key}', value.toString());
      });
    }
    
    return url;
  }
}
