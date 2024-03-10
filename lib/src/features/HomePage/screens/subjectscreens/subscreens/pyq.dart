import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pdfviewscreen.dart';
import '../../../controllers/pyq_controller.dart';
import '../pdfcard.dart';

class PYQScreen extends StatefulWidget {
  PYQScreen({super.key});

  @override
  State<PYQScreen> createState() => _PYQScreenState();
}

class _PYQScreenState extends State<PYQScreen> {
  final pyqcontroller = Get.put(PYQController());

  @override
  void initState() {
    pyqcontroller.getpdf();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pyqcontroller.pyqpdfdata.length,
        itemBuilder: (context, index) {
          return PdfCard(title: pyqcontroller.pyqpdfdata[index]["Name"], press: (){
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (BuildContext context) =>
            //           PDFViewerScreen(url: pyqcontroller.pyqpdfdata[index]["Url"],),
            //     ));
          }, url: pyqcontroller.pyqpdfdata[index]["Url"],);
        },
      ),
    );
  }
}
