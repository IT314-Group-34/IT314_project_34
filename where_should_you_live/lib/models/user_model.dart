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
  List<String>? wishlist;

  User({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.occupation,
    required this.age,
    required this.height,
    required this.ethnicity,
    required this.religion,
    this.wishlist,
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
      wishlist:
          json['wishlist'] != null ? List<String>.from(json['wishlist']) : null,
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
      'wishlist': wishlist,
    };
  }
}

class FirebaseUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    final DocumentReference userRef =
        _firestore.collection('users').doc(user.email);

    await userRef.set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    final DocumentReference userRef =
        _firestore.collection('users').doc(user.email);

    await userRef.update(user.toJson());
  }

  Future<void> deleteUser(String email) async {
    final DocumentReference userRef = _firestore.collection('users').doc(email);

    await userRef.delete();
  }

  Future<List<Map<String, dynamic>>> getWishlist(String email) async {
    final DocumentReference userRef = _firestore.collection('users').doc(email);
    final DocumentSnapshot snapshot = await userRef.get();
    final Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return data?['wishlist'] != null
        ? List<Map<String, dynamic>>.from(
            data!['wishlist'].map((item) => {'cityId': item}))
        : [];
  }

  Future<void> addToWishlist(String email, int cityId) async {
    final DocumentReference userRef = _firestore.collection('users').doc(email);

    await userRef.update({
      'wishlist': FieldValue.arrayUnion([cityId.toString()]),
    });
  }

  Future<void> removeFromWishlist(String email, int cityId) async {
    final DocumentReference userRef = _firestore.collection('users').doc(email);

    await userRef.update({
      'wishlist': FieldValue.arrayRemove([cityId.toString()]),
    });
  }
}
// Usage:
// final FirebaseUserRepository repository = FirebaseUserRepository();
// await repository.removeFromWishlist('user@example.com', 123);