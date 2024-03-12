// User Model

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String username;
  final String? email;
  final String? collage;
  final String? branch;
  final String? year;
  final String? rollno;
  final String? photourl;

  const UserModel({
    this.uid,
    required this.username,
    required this.email,
    required this.collage,
    required this.branch,
    required this.year,
    required this.rollno,
    required this.photourl,
  });

  toJson() {
    return {
      "uid": uid,
      "UserName": username,
      "Email": email,
      "Collage": collage,
      "Branch": branch,
      "Year": year,
      "RollNumber": rollno,
      "photoURL": photourl,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      uid: document.id,
      collage: data!["Collage"],
      branch: data["Branch"],
      year: data["Year"],
      rollno: data["RollNumber"],
      photourl: data["photoURL"],
      username: data["UserName"],
      email: data["Email"],
    );
  }
}
