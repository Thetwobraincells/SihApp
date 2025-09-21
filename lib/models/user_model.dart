// lib/models/user_model.dart
class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? profilePicture;
  final String? grade;
  final String? stream;
  final List<String> interests;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String registrationMethod; // email, google, facebook

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.profilePicture,
    this.grade,
    this.stream,
    this.interests = const [],
    required this.createdAt,
    required this.updatedAt,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.registrationMethod = 'email',
  });

  // Full name getter
  String get fullName => '$firstName $lastName';

  // Display name getter
  String get displayName {
    if (firstName.isNotEmpty) {
      return fullName;
    }
    return email.split('@')[0];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth']) 
          : null,
      profilePicture: json['profilePicture'],
      grade: json['grade'],
      stream: json['stream'],
      interests: List<String>.from(json['interests'] ?? []),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : DateTime.now(),
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      registrationMethod: json['registrationMethod'] ?? 'email',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profilePicture': profilePicture,
      'grade': grade,
      'stream': stream,
      'interests': interests,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'registrationMethod': registrationMethod,
    };
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
    String? grade,
    String? stream,
    List<String>? interests,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    String? registrationMethod,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      grade: grade ?? this.grade,
      stream: stream ?? this.stream,
      interests: interests ?? this.interests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      registrationMethod: registrationMethod ?? this.registrationMethod,
    );
  }
}