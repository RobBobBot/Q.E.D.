import 'dart:io';

class Submission {
  int upvotes;
  double score;
  int noOfTeacherGrades;
  String uploaderID;
  String id;
  List<File> uploadedFiles;
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
