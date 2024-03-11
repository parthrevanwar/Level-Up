import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../common_widgets/custom_eleveted_button.dart';
import '../../../../../common_widgets/multiline_textcontroller.dart';
import '../../../../utils/theme/theme.dart';
import '../../../controllers/Material_controller.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({super.key});

  @override
  State<AddMaterial> createState() => _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {

  final materialcontroller = Get.put(MaterialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.white,
          title: const Text("Add Material"),
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
                  textcontroller: materialcontroller.pdftitle,
                  hinttext: "add title",
                  labeltext: "Pdf title"),
              const SizedBox(
                height: 20,
              ),
              CustomElevetedButtonDark(
                  press: () {
                    if(materialcontroller.pdftitle.text==""){
                      Fluttertoast.showToast(msg: "Please enter a title");
                    }
                    else{
                      materialcontroller.addmaterial(materialcontroller.pdftitle.text);
                      materialcontroller.pdftitle.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  name: "Select pdf"),
            ],
          ),
        ));
  }
}
