import 'package:get/get.dart';

class BranchController extends GetxController {
  static BranchController get instance => Get.find();

  var items = [
    "IT","ITBI","ECE",
  ];

  bool adminon=false;
  String branch="IT";
}
