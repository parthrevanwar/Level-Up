// User Model

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String? email;

  const UserModel({
    this.id,
    required this.email,
    required this.username,
  });

  toJson() {
    return {
      "UserName": username,
      "Email": email,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
        email: data!["Email"],
        username: data["UserName"],
    );
  }
}
