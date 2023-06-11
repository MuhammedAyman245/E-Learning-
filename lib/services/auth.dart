import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> signInwithEmail(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        print(user);
      } else {
        print('shit');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User> signUpWithEmail(
      String name, String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        user.updateDisplayName(name);

        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
          'name': name,
          'email': email,
          'status': 'Unavailable',
          'uid': _auth.currentUser.uid,
        });

        print(user);
      } else {
        print('shit');
      }
    } catch (e) {
      print(e);
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
