import 'package:qed/classes/submission.dart';
import 'package:qed/firebase/rfile.dart';

class Problem {
  final String name;
  final int id;
  Rfile? statementLink, solutionLink;
  final Set<String> tags;
  List<Submission> submissions = [];
  Problem(
      {this.tags = const {},
      required this.name,
      required this.id,
      required this.statementLink,
      required this.solutionLink});
}
