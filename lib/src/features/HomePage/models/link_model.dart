import 'package:cloud_firestore/cloud_firestore.dart';

class LinkModel {
  final String id;
  final String title;
  final String link;

  const LinkModel({
    required this.id,
    required this.title,
    required this.link,
  });

  toJson() {
    return {
      "Id":id,
      "Title": title,
      "Link": link,
    };
  }

  factory LinkModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return LinkModel(
      id: document.id,
      title: data!["Title"],
      link: data["Link"],
    );
  }
}
