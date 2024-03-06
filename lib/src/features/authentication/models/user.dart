// User Model

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String? email;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  toJson() {
    return {
      "UserName": username,
      "Email": email,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
        email: data!["Email"],
        password: data["Password"],
        username: data["UserName"],
    );
  }
}
