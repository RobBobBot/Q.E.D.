import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mime/mime.dart';
import 'package:qed/classes/requester.dart';
import 'package:qed/classes/submission.dart';
import 'package:qed/contest.dart';
import 'package:qed/firebase/rfile.dart';
import 'package:qed/qed_user.dart';

import '../problem.dart';
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
        "profilePicture":
            "https://firebasestorage.googleapis.com/v0/b/unihackqed.appspot.com/o/Users%2FDefaultProfilePicture.jpeg?alt=media&token=21040947-0dab-469f-874a-847d2800c588",
        "role": 0,
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
    // await FirebaseAuth.instance.signOut();
    // await FirebaseAuth.instance.signInWithCredential(cred);
  }

  ///Returns all contests in firebase
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

  ///Gets the data of a given user
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

  ///Returns basic info about an user
  Future<BasicUserInfo> getBasicUserInfo(String uid) async {
    var data =
        (await FirebaseFirestore.instance.collection("Users").doc(uid).get())
            .data();
    if (data == null) throw ("Funk you");
    var res = BasicUserInfo(
        profilePictureURL: data["profilePicture"],
        problemsSolved: data["problemsSolved"],
        nick: data["nickname"],
        rating: data["rating"],
        role: data["res"]);
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

  ///Returns  a link to the problem statement which is a pdf or a img
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

  ///Returns  a link to the problem solution which is a pdf
  Future<Rfile?> getProblemSolution(int id) async {
    Rfile? res;
    await storeageref
        .child('/Problems/$id/Solution')
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
    //TODO
    await FirebaseFirestore.instance
        .collection("Requests")
        .doc(uid)
        .set({"name": name});
  }

  ///Uploads the solutions to a problem
  Future<void> uploadSolution(
      List<PlatformFile> files, String problemID, String uid) async {
    if (files.isEmpty) return;

    try {
      storeageref.child("/Problems/$problemID/Submissions/$uid");
    } catch (e) {}

    for (var file in files) {
      await storeageref
          .child("/Problems/$problemID/Submissions/$uid/${file.name}")
          .putFile(File(file.path!));
    }

    await FirebaseFirestore.instance.collection("Users").doc(uid).update({
      "triedProblems": FieldValue.arrayUnion([int.parse(problemID)]),
    });

    int ind = 0;
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Submissions")
        .get()
        .then((value) {
      ind = value.data()!["ind"];
    });

    ind++;
    Map<String, dynamic> n = {};

    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Submissions")
        .get()
        .then((value) {
      n = value.data()!["stats"];
    });
    n[ind.toString()] = {
      "problem": problemID,
      "uid": uid,
      "upvotes": 0,
      "score": 0,
      "grades": 0,
    };
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Submissions")
        .update({"stats": n});
    Map<String, dynamic> m = {};
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .get()
        .then((value) {
      m = value.data()!["submissions"];
      if (m[problemID] == null) m[problemID] = {};
      m[problemID][uid] = ind;
    });
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .update({"submissions": m});
  }

  ///Return true is a user has submitted a
  Future<bool> hasSubmitted(String uid, String problemID) async {
    int id = int.parse(problemID);
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      for (var i in value.data()!["triedProblems"]) {
        if (i == id) return true;
      }
    });
    return false;
  }

  ///Adds a problem to firebase
  Future<int> createProblem(problemInfo prob) async {
    int ind = 0;

    Map<String, dynamic> m = {};

    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .get()
        .then((value) {
      ind = value.data()!["ind"];
      m = value.data()!["problems"];
    });

    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .update({"ind": ind + 1});

    ind++;

    m[ind.toString()] = prob.name!;

    await storeageref
        .child("Problems/$ind/Statement/${prob.statement!.name}")
        .putFile(File(prob.statement!.path!));

    await storeageref
        .child("Problems/$ind/Solution/${prob.solution!.name}")
        .putFile(File(prob.solution!.path!));

    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .update({"problems": m});

    return ind;
  }

  ///Adds a contest to firebases
  Future<void> createContest(String name, List<problemInfo> problems,
      Timestamp begin, Timestamp end) async {
    int ind = 0;

    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Contests")
        .get()
        .then((value) {
      ind = value.data()!["ind"];
    });

    await FirebaseFirestore.instance.collection("Data").doc("Contests").update({
      "ind": ind + 1,
    });

    ind++;

    List<int> l = [];

    for (var i in problems) {
      l.add(await createProblem(i));
    }

    await FirebaseFirestore.instance
        .collection("Contests")
        .doc((ind).toString())
        .set({
      "begin": begin,
      "end": end,
      "name": name,
      "problemIDs": l,
      "tags": [],
    });
  }

  Future<List<Rfile>> getSubmissionFiles(String pid, String uid) async {
    List<Rfile> res = [];
    await storeageref
        .child("Problems/$pid/Submissions/$uid")
        .listAll()
        .then((value) async {
      for (var i in value.items) {
        res.add(Rfile(
            url: await i.getDownloadURL(),
            isPDF: lookupMimeType(i.fullPath) == "application/pdf"));
      }
    });
    return res;
  }

  ///gets a submisiion(id) of a user(uid) to a problem
  Future<Submission> getSubmissions(String uid, String id, String pid) async {
    late Submission sub;
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Submissions")
        .get()
        .then((value) async {
      var i = value.data()!["stats"][id];
      sub = new Submission(
          upvotes: i["upvotes"],
          score: i["score"],
          noOfTeacherGrades: i["grades"],
          id: id,
          uploaderID: uid,
          uploadedFiles: await getSubmissionFiles(pid, uid));
    });
    return sub;
  }

  ///gets info of a problem
  Future<Problem> getProblem(int id) async {
    late Problem prob;
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .get()
        .then((value) async {
      prob = Problem(
        name: value.data()!["problems"][id.toString()] ?? "noname",
        id: id,
        statementLink: null,
        solutionLink: null,
      );
      Map<String, dynamic>? data = value.data()!["submissions"][id.toString()];
      if (data != null)
        for (var i in data.keys) {
          prob.submissions
              .add(await getSubmissions(i, data[i].toString(), id.toString()));
        }
    });

    prob.statementLink = await getProblemStatements(id);
    prob.solutionLink = await getProblemSolution(id);

    return prob;
  }

  Future<List<Requester>> getRequests() async {
    List<Requester> cereri = [];
    await FirebaseFirestore.instance.collection("Requests").get().then((value) {
      for (var doc in value.docs) {
        cereri.add(Requester(uid: doc.id, name: doc.data()["name"]));
      }
    });
    return cereri;
  }

  Future<void> deleteRequest(String uid) async {
    await FirebaseFirestore.instance.collection("Requests").doc(uid).delete();
  }

  Future<void> maketeacher(String uid) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .update({"role": 1});
  }

  Future<String> getName(String uid) async {
    String res = "";
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) => res = value.data()!["name"]);
    return res;
  }

  Future<List<Problem>> getAllProblems() async {
    List<Problem> res = [];
    await FirebaseFirestore.instance
        .collection("Data")
        .doc("Problems")
        .get()
        .then((value) async {
      for (var i in value.data()!["problems"].keys) {
        res.add(await getProblem(i));
      }
    });
    return res;
  }
}

class BasicUserInfo {
  final int problemsSolved;
  final String nick;
  final String profilePictureURL;
  final int rating;
  final int role;
  BasicUserInfo({
    required this.profilePictureURL,
    required this.problemsSolved,
    required this.nick,
    required this.rating,
    required this.role,
  });
}
