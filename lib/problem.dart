class Problem {
  final String name;
  final int id;
  final String statementLink;
  final Set<String> tags;
  Problem(
      {required this.tags,
      required this.name,
      required this.id,
      required this.statementLink});
}
