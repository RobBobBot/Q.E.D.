import 'package:flutter/material.dart';
import 'package:qed/classes/submission.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SubmissionScreen extends StatelessWidget {
  SubmissionScreen({required this.submission, super.key});
  Submission submission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FittedBox(child: Text('${snapshot.data}\'s submission'));
            }
            return Text("Loading...");
          },
          future: submission.getUploaderName(),
        ),
      ),
      body: Column(
        children: submission.uploadedFiles.map<Widget>((e) {
          if (e.isPDF) return Flexible(flex: 1,
            child: SfPdfViewer.network(e.url));
          return Image.network(e.url);
        }).toList(),
      ),
    );
  }
}
