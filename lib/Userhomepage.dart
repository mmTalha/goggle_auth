import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:time_traveller/auth.dart';

class UserhomePage extends StatelessWidget {


  // ignore: missing_return
  Future<Void> signOut(BuildContext context) async {
    final auth =  Provider.of<Authbase>(context,listen: false);
    try {
      await  auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Void> _confirmsignout(BuildContext context) async {
      final  confirmpass  =     AlertDialog(
      title: Text(' Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('cancel'),
        ),
        FlatButton(onPressed: () {}, child: Text('logout')),
      ],
    );
  }
var user =  FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            child: Text(
             user. email ,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed:()=> signOut(context ),
          )
        ],
      ),
      body: Image.network( user.photoURL),
    );
  }
}
