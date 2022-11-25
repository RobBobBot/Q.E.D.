import 'dart:io';

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
    setState(() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        uploadedFiles.add(File(result.files.first.path!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.problem.name)),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: uploadSolution,
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
