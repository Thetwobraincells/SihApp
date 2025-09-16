class QuizOption {
  final String text;
  final Map<String, int> weights;
  QuizOption({required this.text, required this.weights});
}

class QuizQuestion {
  final String question;
  final List<QuizOption> options;
  QuizQuestion({required this.question, required this.options});
}

final List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: "Which school subject do you enjoy the most among the following?",
    options: [
      QuizOption(text: "(a) Mathematics", weights: {"Science": 2, "Commerce": 0, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "(b) Social Studies", weights: {"Science": 0, "Commerce": 1, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Business Studies", weights: {"Science": 0, "Commerce": 2, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(d) Practical Activities (Labs, PEs, speaking activities, etc.)", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "When solving a difficult problem, what excites you most?",
    options: [
      QuizOption(text: "(a) Finding logical formulas", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(b) Analyzing causes/events", weights: {"Science": 0, "Commerce": 1, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Calculating gains/loss", weights: {"Science": 0, "Commerce": 2, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(d) Building/fixing something", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "If given a choice of career role models, whom would you admire the most?",
    options: [
      QuizOption(text: "(a) Entrepreneur/ Banker", weights: {"Science": 0, "Commerce": 2, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(b) Artist (Writer, Singer, etc.)", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Researcher/ Scientist", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(d) Skilled worker (carpenter/technician)", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "What kind of exams do you find easier?",
    options: [
      QuizOption(text: "(a) Numericals and Problem-Solving", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(b) Theory/ Essays", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Case Studies", weights: {"Science": 0, "Commerce": 2, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(d) Practical Exams", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "Which activity do you enjoy the most?",
    options: [
      QuizOption(text: "(a) Solving puzzles / logical activities", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(b) Writing / drawing / performing arts", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Managing tasks or small-business activities", weights: {"Science": 0, "Commerce": 2, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "(d) Building/Hands-on activities", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "Rate your interest in experimenting with new technologies (like coding, AI, machines).",
    options: [
      QuizOption(text: "1", weights: {"Science": 1, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "2", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "3", weights: {"Science": 3, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "4", weights: {"Science": 4, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "5", weights: {"Science": 5, "Commerce": 0, "Arts": 0, "Vocational": 0}),
    ],
  ),
  QuizQuestion(
    question: "How comfortable are you speaking in front of groups or participating in debates?",
    options: [
      QuizOption(text: "1", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "2", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "3", weights: {"Science": 0, "Commerce": 0, "Arts": 3, "Vocational": 2}),
      QuizOption(text: "4", weights: {"Science": 0, "Commerce": 0, "Arts": 4, "Vocational": 2}),
      QuizOption(text: "5", weights: {"Science": 0, "Commerce": 0, "Arts": 5, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "How much do you enjoy managing or handling money (like saving pocket money, planning budgets)?",
    options: [
      QuizOption(text: "1", weights: {"Science": 0, "Commerce": 1, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "2", weights: {"Science": 0, "Commerce": 2, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "3", weights: {"Science": 0, "Commerce": 3, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "4", weights: {"Science": 0, "Commerce": 4, "Arts": 2, "Vocational": 0}),
      QuizOption(text: "5", weights: {"Science": 0, "Commerce": 5, "Arts": 2, "Vocational": 0}),
    ],
  ),
  QuizQuestion(
    question: "Rate your liking for working with your hands (craft, repairing, drawing models).",
    options: [
      QuizOption(text: "1", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 1}),
      QuizOption(text: "2", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
      QuizOption(text: "3", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 3}),
      QuizOption(text: "4", weights: {"Science": 4, "Commerce": 0, "Arts": 0, "Vocational": 4}),
      QuizOption(text: "5", weights: {"Science": 6, "Commerce": 0, "Arts": 0, "Vocational": 5}),
    ],
  ),
  QuizQuestion(
    question: "How willing are you to study 6–8 hours daily in higher classes for competitive exams?",
    options: [
      QuizOption(text: "1", weights: {"Science": 1, "Commerce": 1, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "2", weights: {"Science": 2, "Commerce": 2, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "3", weights: {"Science": 3, "Commerce": 3, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "4", weights: {"Science": 4, "Commerce": 4, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "5", weights: {"Science": 5, "Commerce": 5, "Arts": 0, "Vocational": 0}),
    ],
  ),
  QuizQuestion(
    question: "Which do you prefer as a pastime?",
    options: [
      QuizOption(text: "(a) Reading informative material", weights: {"Science": 2, "Commerce": 0, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "(b) Creating art or performing", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(c) Playing strategy or money games", weights: {"Science": 0, "Commerce": 2, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "(d) Tinkering / fixing small things", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "Which of these hobbies do you enjoy?",
    options: [
      QuizOption(text: "(a) Painting/Sketching", weights: {"Science": 0, "Commerce": 0, "Arts": 2, "Vocational": 1}),
      QuizOption(text: "(b) Playing team sports", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 2}),
      QuizOption(text: "(c) Reading non-fiction", weights: {"Science": 2, "Commerce": 0, "Arts": 0, "Vocational": 0}),
      QuizOption(text: "(d) Crafting/Modeling", weights: {"Science": 0, "Commerce": 0, "Arts": 0, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "What are your other faviourite hobbies?",
    options: [
      QuizOption(text: "(a) Watching movies/shows on TV", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 1}),
      QuizOption(text: "(b) Playing video games", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 1}),
      QuizOption(text: "(c) Stars Watching/ Astronomy", weights: {"Science": 0, "Commerce": 1, "Arts": 1, "Vocational": 1}),
      QuizOption(text: "(d) Watching/Playing sports", weights: {"Science": 0, "Commerce": 1, "Arts": 1, "Vocational": 2}),
    ],
  ),
  QuizQuestion(
    question: "What type of stories do you like the most?",
    options: [
      QuizOption(text: "(a) Documentary/ Educational", weights: {"Science": 2, "Commerce": 0, "Arts": 1, "Vocational": 0}),
      QuizOption(text: "(b) Thriller/ Action", weights: {"Science": 0, "Commerce": 0, "Arts": 1, "Vocational": 1}),
      QuizOption(text: "(c) Suspense/ Mystery", weights: {"Science": 0, "Commerce": 1, "Arts": 1, "Vocational": 1}),
      QuizOption(text: "(d) A inspirational success story", weights: {"Science": 0, "Commerce": 2, "Arts": 1, "Vocational": 0}),
    ],
  ),
];
