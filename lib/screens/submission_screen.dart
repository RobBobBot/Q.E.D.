import 'package:flutter/material.dart';
import 'package:qed/classes/submission.dart';

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
      body: ListView(
            children: submission.uploadedFiles.map<Widget>((e) {
              if (e.substring(e.length-3) == 'pdf') return Text('pdf');
              return Image.network(e);
            }).toList(),
          ),
      // body: FutureBuilder(
      //   builder: (context, snapshot) {
      //     return ListView(
      //       children: submission.uploadedFiles.map((e) {
      //         if (e.substring(-3) == 'pdf') return Text('pdf');
      //         return NetworkImage(e);
      //       }).toList(),
      //     );
      //   },
      //   // future: ,
      // ),
    );
  }
}
