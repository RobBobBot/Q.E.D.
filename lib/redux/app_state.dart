import 'package:flutter_redux/flutter_redux.dart';
import 'package:qed/contest.dart';
import 'package:qed/problem.dart';
import 'package:qed/qed_user.dart';

class AppState {
  QedUser? currentUser;
  Set<Contest> contests = Set();
  Set<Problem> problems = Set();
}
