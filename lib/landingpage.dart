import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'package:time_traveller/Userhomepage.dart';
import 'package:time_traveller/auth.dart';
import 'package:time_traveller/auth.dart';
import 'package:time_traveller/signinpage.dart';

class landingpage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final auth =  Provider.of<Authbase>(context,listen: false);
    return StreamBuilder(
        stream: auth.authStateChanges(),
        
        builder: (context, snapshot ) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return sign_inpage.Create(context );


            }
            return UserhomePage(

            );
          }
          return Scaffold();
        });
  }
}
