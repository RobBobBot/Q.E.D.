import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/firebase/rfile.dart';

class Submission {
  int upvotes;
  dynamic score;
  int noOfTeacherGrades;
  String uploaderID;
  String id;
  List<Rfile> uploadedFiles;
  Submission(
      {required this.upvotes,
      required this.score,
      required this.noOfTeacherGrades,
      required this.id,
      required this.uploaderID,
      required this.uploadedFiles});
  Future<String> getUploaderName() async {
    return await QEDStore.instance.getName(uploaderID);
  }
}
