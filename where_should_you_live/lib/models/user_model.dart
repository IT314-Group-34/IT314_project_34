import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String firstName;
  String email;
  String lastName;
  String occupation;
  int age;
  double height;
  String ethnicity;
  String religion;

  User({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.occupation,
    required this.age,
    required this.height,
    required this.ethnicity,
    required this.religion,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      email: json['email'] ?? '',
      lastName: json['lastName'] ?? '',
      occupation: json['occupation'] ?? '',
      age: json['age'] ?? 0,
      height: json['height'] ?? 0.0,
      ethnicity: json['ethnicity'] ?? '',
      religion: json['religion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'occupation': occupation,
      'age': age,
      'height': height,
      'ethnicity': ethnicity,
      'religion': religion,
    };
  }
}


