import 'package:qed/contest.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/problem.dart';
import 'package:qed/qed_user.dart';

class AppAction {}

class AddUserAction extends AppAction {
  QedUser user;
  AddUserAction(this.user);
}

class AddContestActions extends AppAction {
  List<Contest> contests;
  AddContestActions(this.contests);
}

class AddProblemAction extends AppAction {
  Problem problem;
  AddProblemAction(this.problem);
}

class UserChangedAction extends AppAction {
  QedUser? user;
  UserChangedAction(this.user);
}

class UserUpdateAction extends AppAction {
  String name;
  String nickname;
  String desc;
  UserUpdateAction(this.name, this.nickname, this.desc);
}
