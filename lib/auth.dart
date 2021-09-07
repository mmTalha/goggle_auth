import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_traveller/EmailSigninform.dart';

abstract class Authbase {
  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signInAnonymously();

  Future<Void> signOut();

  Future<User> signInWithGoogle();

  Future<User> Creatuserwithemailpassword(String email, String password);

  Future<User> signInwithemail(String email, String password);

  Future<User> signInWithFacebook();
}

@override
class Auth implements Authbase {
  User get currentUser => FirebaseAuth.instance.currentUser;
  final _firebaseauth = FirebaseAuth.instance;
  bool loading = false;

  Stream<User> authStateChanges() => _firebaseauth.authStateChanges();

  @override
  Future<User> signInAnonymously() async {
    final usercredential = await FirebaseAuth.instance.signInAnonymously();
    return usercredential.user;
  }

  Future<User> signInwithemail(String email, String password) async {
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  Future<User> Creatuserwithemailpassword(String email, String password) async {
    final usercredential = await _firebaseauth.createUserWithEmailAndPassword(
        email: email, password: password);
    return usercredential.user;
  }

  @override
  // ignore: missing_return
  Future<User> signInWithGoogle() async {
    final googlesSignIn = GoogleSignIn();
    final goggleuser = await googlesSignIn.signIn();
    if (goggleuser != null) {
      final googleauth = await goggleuser.authentication;
      if (googleauth.idToken != null) {
        final userCredential = await _firebaseauth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleauth.idToken,
          idToken: googleauth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            message: 'Error abborted by user ',
            code: 'Signin abborted By user');
      }
    }

    // Once signed in, return the UserCredential
  }

  @override
  // Future<User> signInWithFacebook() {
  //   // TODO: implement signInWithFacebook
  //   throw UnimplementedError();
  // }

  @override
//   Future<Void> signOut() {
//     /
//     throw UnimplementedError();
//   }
// }

  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final acesstoken = response.accessToken;
        final UserCredential = await FirebaseAuth.instance.signInWithCredential(
            FacebookAuthProvider.credential(acesstoken.token));
        return UserCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
            message: 'error abborted by user',
            code: 'signin abborted by user'
                '');
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            message: ' login error abborted by user',
            code: response.error.developerMessage);
    }
  }

  @override
  Future<Void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
