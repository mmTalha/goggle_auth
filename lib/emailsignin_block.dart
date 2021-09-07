import 'dart:async';
import 'dart:ffi';

import 'package:time_traveller/EmailSigninform.dart';
import 'package:time_traveller/Signin_model.dart';
import 'package:time_traveller/auth.dart';

class EmailSigninblock {
  final Authbase auth;
  final StreamController<Emailsigininmodel> modelcontroller =
      StreamController<Emailsigininmodel>();

  EmailSigninblock(this.auth);

  Stream<Emailsigininmodel> get modelstream => modelcontroller.stream;
  Emailsigininmodel model = Emailsigininmodel();

  void dispose() {
    modelcontroller.close();
  }

  void UpdateWith({
    String email,
    String password,
    Formtype,
    bool isloading,
    bool is_submitted,
  }) {
    model = model.Copywith(
      email: email,
      password: password,
      formtype: Formtype,
      islaoding: isloading,
      submitted: is_submitted,
    );
    modelcontroller.add(model);
  }


  Future<Void>   submit() async {
     UpdateWith(is_submitted: true,isloading: true);
    try {

      if (model.formtype == Signinformtype.signin) {

        await  auth.signInwithemail(model.email,model.password);
        UpdateWith(isloading: false);
      } else {
        await auth.Creatuserwithemailpassword(model.email, model.password);
        UpdateWith(isloading: false);
    } }catch (e) {

      print(e.toString());













}}}
