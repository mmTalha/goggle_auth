import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:time_traveller/auth.dart';

class SignInblock {
  SignInblock({@required this.auth});

  final Authbase auth;
  final StreamController<bool> isloadingcontroller = StreamController<bool>();

  Stream<bool> get isloadingstream => isloadingcontroller.stream;

  void dispose() {
    isloadingcontroller.close();
  }

  void setisloading(bool isloading) {
    isloadingcontroller.add(isloading);
  }

  Future<User> Signin(Future<User> Function() signinmethod) async {
    try {
      setisloading(true);
      return await signinmethod();
    } catch (e) {
      rethrow;
    } finally {
      setisloading(false);
    }
  }

  Future<User> signInAnonymously() async =>
      await Signin(() => auth.signInAnonymously());

  Future<User> signInWithGoogle() async {
    await Signin(auth.signInWithGoogle);
  }

  Future<User> signInWithFacebook() async =>
      await Signin(() => auth.signInWithFacebook());
}
