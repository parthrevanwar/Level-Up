import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/controllers/pyq_controller.dart';

import '../../../../../common_widgets/custom_eleveted_button.dart';
import '../../../../../common_widgets/multiline_textcontroller.dart';
import '../../../../utils/theme/theme.dart';

class AddPYQ extends StatefulWidget {
  const AddPYQ({super.key});

  @override
  State<AddPYQ> createState() => _AddPyqState();
}

class _AddPyqState extends State<AddPYQ> {
  final pyqcontroller = Get.put(PYQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.white,
          title: Text("Add PYQs"),
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
                  textcontroller: pyqcontroller.pdftitle,
                  hinttext: "add title",
                  labeltext: "Pdf title"),
              const SizedBox(
                height: 20,
              ),
              CustomElevetedButtonDark(
                  press: () {
                    if(pyqcontroller.pdftitle.text==""){
                      Fluttertoast.showToast(msg: "Please enter a title");
                    }
                    else{
                      pyqcontroller.addpyq(pyqcontroller.pdftitle.text);
                      pyqcontroller.pdftitle.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  name: "Select pdf"),
            ],
          ),
        ));
  }
}
