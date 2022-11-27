import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Submission {
  int upvotes;
  double score;
  int noOfTeacherGrades;
  String uploaderID;
  String id;
  List<String> uploadedFiles;
  Submission(
      {required this.upvotes,
      required this.score,
      required this.noOfTeacherGrades,
      required this.id,
      required this.uploaderID,
      required this.uploadedFiles});
  String getUploaderName() {
    ///TODO ceva
    return 'Uploader name';
  }
}
