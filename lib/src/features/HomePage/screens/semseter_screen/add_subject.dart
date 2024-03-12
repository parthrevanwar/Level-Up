import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import '../../../../common_widgets/multiline_textcontroller.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/subject_controller.dart';

class AddSubject extends StatefulWidget {
  AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final subjectcontroller = Get.put(SubjectController());
  final semestercontroller = Get.put(SemesterController());

  bool it = false;

  bool ece = false;

  bool itbi = false;

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
          child: SingleChildScrollView(
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
                Row(
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: it,
                            onChanged: (value) {
                              setState(() {
                                it = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "IT",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: itbi,
                            onChanged: (value) {
                              setState(() {
                                itbi = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ITBI",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: ece,
                            onChanged: (value) {
                              setState(() {
                                ece = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ECE",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomElevetedButtonDark(
                    press: () {
                      subjectcontroller.addsubject(
                          subjectcontroller.title.text,
                          subjectcontroller.subtitle.text,
                          subjectcontroller.subjectid.text,
                          semestercontroller.semester,
                          it,
                          itbi,
                          ece);
                      subjectcontroller.clearText();
                      Navigator.of(context).pop();
                    },
                    name: "Add Subject"),
              ],
            ),
          ),
        ));
  }
}
