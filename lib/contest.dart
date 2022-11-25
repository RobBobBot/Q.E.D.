import 'package:qed/problem.dart';

class Contest {
  final Set<int> problemIDs;
  final Set<String> tags;
  final String name;
  final int id;
  Contest(
      {required this.id,
      required this.tags,
      required this.name,
      required this.problemIDs});
}
