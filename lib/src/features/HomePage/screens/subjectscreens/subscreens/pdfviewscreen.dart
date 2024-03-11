import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.url, required this.title});

  final url;
  final title;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 18),),
        backgroundColor: AppTheme.colors.black,
      ),
      body: PDF(
      ).cachedFromUrl(widget.url,
          placeholder: (progress) => Center(
            child: Text("Loading - $progress %"),
          ),
          errorWidget: (error) => Center(
            child: Text("An error occured while opening bill PDF"),
          )),
    );
  }
}
