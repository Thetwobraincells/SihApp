import 'package:flutter/foundation.dart';
import '../models/quiz_model.dart';

class QuizController extends ChangeNotifier {
  // Current quiz state
  int _currentQuestionIndex = 0;
  List<QuizOption?> _selectedAnswers = [];
  bool _isQuizCompleted = false;
  
  // Results
  Map<String, int> _streamScores = {
    'Science': 0,
    'Commerce': 0,
    'Arts': 0,
    'Vocational': 0,
  };
  String _recommendedStream = '';
  
  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => quizQuestions.length;
  List<QuizOption?> get selectedAnswers => _selectedAnswers;
  bool get isQuizCompleted => _isQuizCompleted;
  Map<String, int> get streamScores => _streamScores;
  String get recommendedStream => _recommendedStream;
  
  // Get current question
  QuizQuestion get currentQuestion => quizQuestions[_currentQuestionIndex];
  
  // Check if current question is answered
  bool get isCurrentQuestionAnswered => 
      _currentQuestionIndex < _selectedAnswers.length && 
      _selectedAnswers[_currentQuestionIndex] != null;
  
  // Get progress percentage
  double get progressPercentage => (_currentQuestionIndex + 1) / totalQuestions;
  
  // Initialize quiz
  void initializeQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers = List.filled(quizQuestions.length, null);
    _isQuizCompleted = false;
    _streamScores = {
      'Science': 0,
      'Commerce': 0,
      'Arts': 0,
      'Vocational': 0,
    };
    _recommendedStream = '';
    notifyListeners();
  }
  
  // Select an answer for current question
  void selectAnswer(QuizOption option) {
    if (_currentQuestionIndex < quizQuestions.length) {
      // Ensure the selectedAnswers list is large enough
      while (_selectedAnswers.length <= _currentQuestionIndex) {
        _selectedAnswers.add(null);
      }
      
      _selectedAnswers[_currentQuestionIndex] = option;
      notifyListeners();
    }
  }
  
  // Get selected answer for a specific question
  QuizOption? getSelectedAnswer(int questionIndex) {
    if (questionIndex < _selectedAnswers.length) {
      return _selectedAnswers[questionIndex];
    }
    return null;
  }
  
  // Go to next question
  void nextQuestion() {
    if (_currentQuestionIndex < quizQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }
  
  // Go to previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }
  
  // Jump to specific question
  void goToQuestion(int index) {
    if (index >= 0 && index < quizQuestions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }
  
  // Calculate final results
  void calculateResults() {
    // Reset scores
    _streamScores = {
      'Science': 0,
      'Commerce': 0,
      'Arts': 0,
      'Vocational': 0,
    };
    
    // Calculate scores based on selected answers
    for (int i = 0; i < _selectedAnswers.length; i++) {
      final selectedOption = _selectedAnswers[i];
      if (selectedOption != null) {
        selectedOption.weights.forEach((stream, weight) {
          _streamScores[stream] = (_streamScores[stream] ?? 0) + weight;
        });
      }
    }
    
    // Find recommended stream (highest score)
    _recommendedStream = _streamScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    
    _isQuizCompleted = true;
    notifyListeners();
  }
  
  // Check if quiz can be submitted (all questions answered)
  bool canSubmitQuiz() {
    return _selectedAnswers.length == quizQuestions.length &&
           _selectedAnswers.every((answer) => answer != null);
  }
  
  // Get stream description
  String getStreamDescription(String stream) {
    switch (stream) {
      case 'Science':
        return 'Perfect for students interested in research, innovation, and technical problem-solving. Leads to careers in engineering, medicine, research, and technology.';
      case 'Commerce':
        return 'Ideal for students with business acumen and numerical skills. Opens doors to careers in finance, accounting, business management, and entrepreneurship.';
      case 'Arts':
        return 'Great for creative minds and strong communicators. Leads to careers in literature, journalism, social work, psychology, and creative fields.';
      case 'Vocational':
        return 'Perfect for hands-on learners who prefer practical skills. Leads to careers in skilled trades, technical fields, and specialized professions.';
      default:
        return 'Explore your interests and discover your ideal career path.';
    }
  }
  
  // Get stream subjects
  List<String> getStreamSubjects(String stream) {
    switch (stream) {
      case 'Science':
        return ['Physics', 'Chemistry', 'Mathematics', 'Biology'];
      case 'Commerce':
        return ['Accountancy', 'Business Studies', 'Economics', 'Mathematics'];
      case 'Arts':
        return ['History', 'Political Science', 'Psychology', 'Sociology'];
      case 'Vocational':
        return ['Technical Skills', 'Practical Training', 'Industry Certification', 'Hands-on Learning'];
      default:
        return [];
    }
  }
  
  // Get career examples for stream
  List<String> getStreamCareers(String stream) {
    switch (stream) {
      case 'Science':
        return ['Engineer', 'Doctor', 'Researcher', 'Data Scientist', 'Biotechnologist'];
      case 'Commerce':
        return ['CA/CPA', 'Business Analyst', 'Investment Banker', 'Entrepreneur', 'Financial Advisor'];
      case 'Arts':
        return ['Journalist', 'Psychologist', 'Teacher', 'Social Worker', 'Content Writer'];
      case 'Vocational':
        return ['Technician', 'Skilled Craftsperson', 'Chef', 'Graphic Designer', 'Web Developer'];
      default:
        return [];
    }
  }
  
  // Reset quiz
  void resetQuiz() {
    initializeQuiz();
  }
}