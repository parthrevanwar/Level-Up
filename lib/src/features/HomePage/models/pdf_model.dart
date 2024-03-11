import 'package:cloud_firestore/cloud_firestore.dart';

class PdfModel {
  final String? id;
  final String? name;
  final String? url;

  const PdfModel({
    required this.id,
    required this.name,
    required this.url,
  });

  toJson() {
    return {
      "Id":id,
      "Name": name,
      "Url": url,
    };
  }

  factory PdfModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return PdfModel(
      id: document.id,
      name: data!["Name"],
      url: data["Url"],
    );
  }
}
