import 'package:firebase_auth/firebase_auth.dart';

class QedUser {
  String name, profilePictureURL;
  bool canCreateContests, canDeleteContests, canDeleteSubmissions;
  User firebaseUser;
  QedUser(
      {this.canCreateContests = false,
      this.canDeleteContests = false,
      this.canDeleteSubmissions = false,
      required this.name,
      required this.profilePictureURL,
      required this.firebaseUser});
}
