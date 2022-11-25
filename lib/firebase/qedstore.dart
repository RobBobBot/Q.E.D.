import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .set({"Name": name, "profilePicture": "Users/.jpeg", "role": "user"});
    }
    return res;
  }

  Future<QedUser> getUserData(String uid) async {
    QedUser res = QedUser();
    return res;
  }
}
