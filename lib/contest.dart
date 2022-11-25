import 'package:qed/problem.dart';

class Contest {
  final Set<int> problemIDs;
  final Set<String> tags;
  final String name;
  Contest({required this.tags, required this.name, required this.problemIDs});
}
