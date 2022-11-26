import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qed/contest.dart';
import 'package:qed/qed_user.dart';

class QEDStore {
  static final QEDStore instance = QEDStore._internal();
  final Reference storeageref = FirebaseStorage.instance.ref();
  factory QEDStore() {
    return instance;
  }

  QEDStore._internal();

  ///Creates a firebaseAuth user and adds it to firestore
  ///and returns null or returns a error code if an error occured.
  ///
  ///  Error codes:
  /// - email-already-in-use
  /// - invalid-email
  /// - weak-password
  /// - unknown(if the error is not known)
  Future<String?> createUser(
      {required String name,
      required String nickname,
      required String email,
      required String password}) async {
    String? res;
    User? user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {user = value.user});
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = "unknown";
    }
    if (user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
        "name": name,
        "nickname": nickname,
        "profilePicture": "Users/DefaultProfilePicture.jpeg",
        "role": "student",
        "description": "",
        "rating": 0.0,
        "problemsSolved": 0
      });
    }
    return res;
  }

  Future<void> singInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    if (user == null) return;
    final GoogleSignInAuthentication? auth = await user.authentication;
    final cred = GoogleAuthProvider.credential(
        idToken: auth?.idToken, accessToken: auth?.accessToken);
    User u = (await FirebaseAuth.instance.signInWithCredential(cred)).user!;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(u.uid)
        .get()
        .then((value) async {
      if (!value.exists) {
        await FirebaseFirestore.instance.collection("Users").doc(u.uid).set({
          "name": u.displayName,
          "nickname": u.displayName,
          "profilePicture": u.photoURL,
          "role": "student",
          "description": "",
          "rating": 0.0,
          "problemsSolved": 0
        });
      }
    });
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.signInWithCredential(cred);
  }

  Future<List<Contest>> getContests() async {
    List<Contest> res = [];
    await FirebaseFirestore.instance.collection("Contests").get().then((value) {
      for (var doc in value.docs) {
        Set<int> problems = Set<int>();
        Set<String> tags = Set<String>();
        for (var i in doc.data()["tags"]) {
          tags.add(i);
        }
        for (var i in doc.data()["problemIDs"]) {
          problems.add(i);
        }
        res.add(
          Contest(
              id: int.parse(doc.id),
              tags: tags,
              name: doc.data()["name"],
              problemIDs: problems,
              timeBegin: doc.data()["begin"],
              timeEnd: doc.data()["end"]),
        );
      }
    });
    return res;
  }

  Future<QedUser> getUserData(User user) async {
    late QedUser res;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((value) {
      var data = value.data()!;
      res = QedUser(
          name: data["name"],
          profilePictureURL: data["profilePicture"],
          firebaseUser: user,
          description: data["description"],
          nickname: data["nickname"],
          role: data["role"],
          problemsSolved: data["problemsSolved"],
          rating: data["rating"]);
    });
    return res;
  }

  Future<String?> getStatementURL(int id) async {
    String? res;

    return res;
  }
}
