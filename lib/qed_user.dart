import 'package:firebase_auth/firebase_auth.dart';

class QedUser {
  String nickname, name, profilePictureURL, description, role;
  bool canCreateContests, canDeleteContests, canDeleteSubmissions;
  User firebaseUser;
  int problemsSolved;
  double rating;
  QedUser(
      {this.canCreateContests = false,
      this.canDeleteContests = false,
      this.canDeleteSubmissions = false,
      required this.description,
      required this.name,
      required this.nickname,
      required this.profilePictureURL,
      required this.firebaseUser,
      required this.role,
      required this.problemsSolved,
      required this.rating});
}
