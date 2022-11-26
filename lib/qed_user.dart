import 'package:firebase_auth/firebase_auth.dart';

//robert nu ma injura
const int student = 0;
const int teacher = 1;
const int admin = 2;

class QedUser {
  String nickname, name, profilePictureURL, description;
  int role;
  User firebaseUser;
  int problemsSolved;
  double rating;
  QedUser(
      {this.role = student,
      required this.description,
      required this.name,
      required this.nickname,
      required this.profilePictureURL,
      required this.firebaseUser,
      required this.problemsSolved,
      required this.rating});
}
