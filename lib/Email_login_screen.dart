import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_traveller/EmailSigninform.dart';
import 'package:time_traveller/auth.dart';
import 'package:time_traveller/email_signin_form_block_based.dart';


class Email_sign_in extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final auth =  Provider.of<Authbase>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title:   Text('Time Tracker')),
        body:  Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Card(

              elevation: 4.0,
                  child:Emailsign_formBloc_based.create(context  ),
                ),
          ),
        ),


    );
  }
}
