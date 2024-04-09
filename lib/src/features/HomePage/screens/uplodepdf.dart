// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
//
// class YourController {
//   final _firebaseFirestore = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;
//
//
// }
//
// // Example usage in your widget
// class YourWidget extends StatelessWidget {
//   final YourController controller = YourController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload File'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await controller.pickFile("pdf", "MyFileTitle", context);
//           },
//           child: Text('Pick and Upload File'),
//         ),
//       ),
//     );
//   }
// }
