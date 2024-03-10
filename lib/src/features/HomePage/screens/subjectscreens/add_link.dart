import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import '../../../../common_widgets/multiline_textcontroller.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/links_controller.dart';
import '../../controllers/subject_controller.dart';

class AddLink extends StatelessWidget {
  AddLink({super.key});


  final linkcontroller = Get.put(LinkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.white,
          title: Text("Add Link"),
          shape: Border(
              bottom: BorderSide(
                color: AppTheme.colors.lightgray,
                width: 2,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              MultilineCustomTextField(
                  textcontroller: linkcontroller.title,
                  hinttext: "add Title",
                  labeltext: "Title"),
              SizedBox(
                height: 10,
              ),
              MultilineCustomTextField(
                  textcontroller: linkcontroller.link,
                  hinttext: "add link",
                  labeltext: "Link"),
              SizedBox(
                height: 20,
              ),
              CustomElevetedButtonDark(
                  press: () {
                    linkcontroller.addlink();
                    linkcontroller.clearText();
                    Navigator.of(context).pop();
                  },
                  name: "Add Link"),
            ],
          ),
        ));
  }
}
