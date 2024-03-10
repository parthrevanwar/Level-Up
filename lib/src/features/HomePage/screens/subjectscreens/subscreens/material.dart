import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/pdfcard.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pdfviewscreen.dart';
import '../../../controllers/Material_controller.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final materialcontroller = Get.put(MaterialController());

  @override
  void initState() {
    materialcontroller.getpdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: materialcontroller.materialpdfdata.length,
        itemBuilder: (context, index) {
          return PdfCard(
            title: materialcontroller.materialpdfdata[index]["Name"],
            url: materialcontroller.materialpdfdata[index]["Url"],
            press: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (BuildContext context) =>
              //           PDFViewerScreen(url: materialcontroller.materialpdfdata[index]["Url"],),
              //     ));
            },
          );
        },
      ),
    );
  }
}
