import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import '../../../../common_widgets/multiline_textcontroller.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/subject_controller.dart';

class AddSubject extends StatelessWidget {
  AddSubject({super.key});

  final subjectcontroller = Get.put(SubjectController());
  final semestercontroller = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.white,
          title: Text("Add Subject"),
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
                  textcontroller: subjectcontroller.title,
                  hinttext: "add shortform",
                  labeltext: "Shortform"),
              SizedBox(
                height: 10,
              ),
              MultilineCustomTextField(
                  textcontroller: subjectcontroller.subtitle,
                  hinttext: "add subtitle",
                  labeltext: "SubjectName"),
              SizedBox(
                height: 10,
              ),
              MultilineCustomTextField(
                  textcontroller: subjectcontroller.subjectid,
                  hinttext: "add subjectid",
                  labeltext: "SubjectId"),
              SizedBox(
                height: 20,
              ),
              CustomElevetedButtonDark(
                  press: () {
                    subjectcontroller.addsubject(
                        subjectcontroller.title.text,
                        subjectcontroller.subtitle.text,
                        subjectcontroller.subjectid.text,
                        semestercontroller.semester);
                    subjectcontroller.clearText();
                    Navigator.of(context).pop();
                  },
                  name: "Add Subject"),
            ],
          ),
        ));
  }
}
