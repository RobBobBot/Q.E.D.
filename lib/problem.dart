import 'package:qed/firebase/rfile.dart';

class Problem {
  final String name;
  final int id;
  final Rfile? statementLink;
  final Set<String> tags;
  Problem(
      {required this.tags,
      required this.name,
      required this.id,
      required this.statementLink});
}
