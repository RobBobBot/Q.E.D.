import 'dart:io';
import 'dart:math';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../problem.dart';

class ProblemScreen extends StatefulWidget {
  Problem problem;

  ProblemScreen({required this.problem, super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  List<File> uploadedFiles = [];

  Future<void> uploadSolution() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      uploadedFiles.add(File(result.files.first.path!));
    }
    setState(() {});
  }

  PDFDocument? doc;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  void submitSolutions() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf')
    //     .then((value) => doc = value);
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var initHeight = 400;

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.problem.name),
          actions: [
            IconButton(onPressed: submitSolutions, icon: Icon(Icons.send))
          ],
        ),
        body: Column(
          children: [
            // doc != null ? PDFViewer(document: doc!) : Container(),
            Flexible(
              flex: 1,
              child: SfPdfViewer.network(
                'https://www.africau.edu/images/default/sample.pdf',
                key: _pdfViewerKey,
              ),
            ),
            screenheight > initHeight + 83
                ? Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: uploadSolution,
                          child: Text("Upload"),
                        ),
                        ...uploadedFiles.map(
                          (f) => ListTile(
                            title: Text(
                                f.path.substring(f.path.lastIndexOf('/') + 1)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
