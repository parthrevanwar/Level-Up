import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageApi {

  static Future<void> deleteFolder({
    required String path
  }) async {
    List<String> paths = [];
    paths = await _deleteFolder(path, paths);
    for (String path in paths) {
      await FirebaseStorage.instance.ref().child(path).delete();
    }
  }

  static Future<List<String>> _deleteFolder(String folder, List<String> paths) async {
    ListResult list = await FirebaseStorage.instance.ref().child(folder).listAll();
    List<Reference> items = list.items;
    List<Reference> prefixes = list.prefixes;
    for (Reference item in items) {
      paths.add(item.fullPath);
    }
    for (Reference subfolder in prefixes) {
      paths = await _deleteFolder(subfolder.fullPath, paths);
    }
    return paths;
  }

}