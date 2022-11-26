import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qed/problem.dart';

class Contest {
  final Set<int> problemIDs;
  final Set<String> tags;
  final String name;
  final int id;
  final Timestamp timeBegin;
  final Timestamp timeEnd;
  Contest(
      {required this.timeBegin,
      required this.timeEnd,
      required this.id,
      required this.tags,
      required this.name,
      required this.problemIDs});
  bool isFinished() {
    Timestamp currentTime = Timestamp.fromDate(DateTime.now());
    return timeEnd.compareTo(currentTime) < 0;
  }

  bool isUpcoming() {
    Timestamp currentTime = Timestamp.fromDate(DateTime.now());
    return timeBegin.compareTo(currentTime) > 0;
  }
}
