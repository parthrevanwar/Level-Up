import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String? id;
  final String? subjectid;
  final String shortform;
  final String name;

  const SubjectModel({
    this.id,
    required this.subjectid,
    required this.shortform,
    required this.name,
  });

  toJson() {
    return {
      "ShortForm": shortform,
      "Name": name,
      "SubjectId": subjectid,
    };
  }

  factory SubjectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return SubjectModel(
      id: document.id,
      subjectid: data!["SubjectId"],
      shortform: data["ShortForm"],
      name: data["Name"],
    );
  }
}
