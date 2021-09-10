import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:time_traveller/CustomRaisedButton.dart';
import 'package:time_traveller/Email_login_screen.dart';
import 'package:time_traveller/Signin_block.dart';
import 'package:time_traveller/auth.dart';
import 'package:time_traveller/landingpage.dart';

class sign_inpage extends StatelessWidget {
  final SignInblock bloc;

  sign_inpage({
    Key key,
    @required this.bloc,
  }) : super(key: key);



  static Widget Create(BuildContext context) {
    final auth = Provider.of<Authbase>(context, listen: false);


    return Provider<SignInblock>(
        create: (_) => SignInblock(auth: auth),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<SignInblock>(
          builder: (_, bloc, __) => sign_inpage(
            bloc: bloc,
          ),
        ));
  }

  Future<Void> SigninAnontmous(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {


    try {
      await bloc.signInWithFacebook();
    } catch (e) {
      print(e.toString());

    }
  }

  void SignInWithEmail(context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => Email_sign_in()));
  }

  Future<void> SignInwithGoggle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      bloc.setisloading(true);
      print(e.toString());
    }
  }

  Widget build(
    BuildContext context,
  ) {
    final bloc = Provider.of<SignInblock>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Time Tracker')),
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isloadingstream,
          initialData: false,
          builder: (context, snapshot) {
            return buildcontent(context, snapshot.data);

            // SingleChildScrollView(
            //   child: Container(
            //
            //     padding: EdgeInsets.all(20),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //                 widget.isloading?Center(child: CircularProgressIndicator()):
            //         Text(
            //           'Sign in',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 32.00,
            //             color: Colors.black,
            //             fontWeight: FontWeight.w300,
            //           ),
            //         ),
            //         SizedBox(
            //           height: 48,
            //         ),
            //         CustomRaisedButton(
            //             child: Text(
            //               'Sign In with  Google',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 15,
            //               ),
            //             ),
            //             color: Colors.red,
            //             onpressed: () => SignInwithGoggle),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         CustomRaisedButton(
            //             child: Text(
            //               'Sign In with Facbook',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 15,
            //               ),
            //             ),
            //             color: Colors.indigo,
            //             onpressed: () => signInWithFacebook(context)),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         CustomRaisedButton(
            //             child: Text(
            //               'Sign In Email',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 15,
            //               ),
            //             ),
            //             color: Colors.teal[700],
            //             onpressed: () => SignInWithEmail(context)),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           'or',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 20.0,
            //             color: Colors.black87,
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         CustomRaisedButton(
            //             child: Text(
            //               'Sign In with Anonymous',
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 15,
            //               ),
            //             ),
            //             color: Colors.lime,
            //             onpressed: () => SigninAnontmous( context  )),
            //
            //       ],
            //     ),
            //   ),
            // );
          }),
    );
  }

  Widget buildcontent(BuildContext context, bool isloading) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isloading
                ? Center(child: CircularProgressIndicator())
                : Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.00,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
            SizedBox(
              height: 48,
            ),
            CustomRaisedButton(
                child: Text(
                  'Sign In with  Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                color: Colors.red,
                onpressed: () => SignInwithGoggle(context)),
            SizedBox(
              height: 10,
            ),
            CustomRaisedButton(
                child: Text(
                  'Sign In with Facbook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                color: Colors.indigo,
                onpressed: () => signInWithFacebook(context)),
            SizedBox(
              height: 10,
            ),
            CustomRaisedButton(
                child: Text(
                  'Sign In Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                color: Colors.teal[700],
                onpressed: () {}),

            SizedBox(
              height: 10,
            ),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedButton(
                child: Text(
                  'Sign In with Anonymous',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                color: Colors.lime,
                onpressed: () => SigninAnontmous(context)),
          ],
        ),
      ),
    );
  }
}
