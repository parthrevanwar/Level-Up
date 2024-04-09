import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common_widgets/custom_eleveted_button.dart';
import '../../../../common_widgets/multiline_textcontroller.dart';



class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {

  final admincontroller = Get.put(AdminController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Admin"),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              MultilineCustomTextField(
                  textcontroller: admincontroller.newadminname,
                  hinttext: "add Name",
                  labeltext: "Name"),
              SizedBox(
                height: 10,
              ),
              MultilineCustomTextField(
                  textcontroller: admincontroller.newadminemail,
                  hinttext: "add email",
                  labeltext: "Email"),
              SizedBox(
                height: 10,
              ),MultilineCustomTextField(
                  textcontroller: admincontroller.newadminsubjects,
                  hinttext: "add subjects seperated by comma",
                  labeltext: "Subjects"),
              SizedBox(
                height: 20,
              ),
              CustomElevetedButtonDark(
                  press: () {
                    if(admincontroller.newadminname.text==""){
                      Fluttertoast.showToast(msg: "Please enter a title");
                    }else if(admincontroller.newadminemail.text==""){
                      Fluttertoast.showToast(msg: "Please enter a link");
                    }
                    else{
                      admincontroller.addadmin();
                      admincontroller.newadminname.clear();
                      admincontroller.newadminemail.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  name: "Add"),
            ],
          ),
        ));
  }
}
