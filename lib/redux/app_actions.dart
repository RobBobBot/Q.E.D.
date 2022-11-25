import 'package:qed/contest.dart';
import 'package:qed/problem.dart';
import 'package:qed/qed_user.dart';

class AppAction {}

class AddUserAction extends AppAction {
  QedUser user;
  AddUserAction(this.user);
}

class AddContestAction extends AppAction {
  Contest contest;
  AddContestAction(this.contest);
}

class AddProblemAction extends AppAction {
  Problem problem;
  AddProblemAction(this.problem);
}
