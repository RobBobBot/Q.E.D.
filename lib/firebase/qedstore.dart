import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mime/mime.dart';
import 'package:qed/contest.dart';
import 'package:qed/firebase/rfile.dart';
import 'package:qed/qed_user.dart';

import '../probleminfo.dart';

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
  Future<String?> signUpUser(
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

  ///Sign in a user with email and password
  ///
  ///Error codes:
  /// - invalid-email
  /// - user-not-found
  /// - wrong-password
  /// - unknown
  Future<String?> signInUser(
      {required String email, required String password}) async {
    String? res;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = "unknown";
    }
    return res;
  }

  /// Creates a account with Google or sign in with Google
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
          "role": 0,
          "description": "",
          "rating": 0.0,
          "problemsSolved": 0
        });
      }
    });
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.signInWithCredential(cred);
  }

  //Returns all contests in firebase
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

  //Gets the data of a given user
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

  ///Signs out a user
  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  ///Updates the data of a user
  Future<void> updateUser(
      {required String nickname,
      required String name,
      required String desc,
      required String uid}) async {
    FirebaseFirestore.instance.collection("Users").doc(uid).update({
      "description": desc,
      "name": name,
      "nickname": nickname,
    });
  }

  ///Returns links to all problem statements and if they're pdf or img
  Future<Rfile?> getProblemStatements(int id) async {
    Rfile? res;
    await storeageref
        .child('/Problems/$id/Statement')
        .listAll()
        .then((value) async {
      for (var i in value.items) {
        res = Rfile(
            url: await i.getDownloadURL(),
            isPDF: lookupMimeType(i.fullPath) == "application/pdf");
      }
    });
    return res;
  }

  ///Adds a request of the user to become teacher
  Future<void> addRequest(String uid, String name) async {
    await FirebaseFirestore.instance
        .collection("Requests")
        .doc(uid)
        .set({"name": name});
  }

  ///Uploads the solutions to a problem
  Future<void> uploadSolution(
      List<PlatformFile> files, String problemID, String uid) async {
    if (files.isEmpty) return;

    storeageref.child("/Problems/$problemID/Submissions/$uid").delete();

    for (var file in files) {
      await storeageref
          .child("/Problems/$problemID/Submissions/$uid/${file.name}")
          .putFile(File(file.path!));
    }

    await FirebaseFirestore.instance.collection("Users").doc(uid).update({
      "triedProblems": FieldValue.arrayUnion([int.parse(problemID)]),
    });
  }

  Future<bool> hasSubmitted(String uid, String problemID) async {
    bool res = true;
    return res;
  }
  Future<void> createContest(String name, List<problemInfo> problems,
      Timestamp begin, Timestamp end) async {}
}
