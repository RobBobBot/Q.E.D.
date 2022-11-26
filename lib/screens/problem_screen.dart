import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf')
        .then((value) => doc = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.problem.name)),
      body: ListView(
        children: [
          doc != null ? PDFViewer(document: doc!) : Container(),
          ElevatedButton(
            onPressed: uploadSolution,
            child: Text("Upload"),
          ),
          ...uploadedFiles.map(
            (f) => ListTile(
              title: Text(f.path),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
