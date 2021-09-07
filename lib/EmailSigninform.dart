import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_traveller/Signin_model.dart';

import 'package:time_traveller/auth.dart';
import 'package:time_traveller/vallidator.dart';



class Email_Signinform_stateful extends StatefulWidget with EmailandpasswordVallidators {


  @override
  _Email_Signinform_statefulState createState() => _Email_Signinform_statefulState();
}

class _Email_Signinform_statefulState extends State<Email_Signinform_stateful> {
  Signinformtype _formtype = Signinformtype.signin;
  final TextEditingController emailconroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();

  String get _email => emailconroller.text;

  String get _password => passcontroller.text;
  bool submited = false;
  bool _isloading = false;

  void toggleform() {
    setState(() {
      submited = false;
      _formtype = _formtype == Signinformtype.signin
          ? Signinformtype.register
          : Signinformtype.signin;
    });
  }

  void submit() async {
    bool loading  = false;
    setState(() {
      submited = true;
      _isloading = true;
    });
    try {
      final auth =  Provider.of<Authbase>(context,listen: false);
      if (_formtype == Signinformtype.signin) {

        await  auth.signInwithemail(_email, _password);
        setState(() {
          loading= true;
        });
      } else {
        await auth.Creatuserwithemailpassword(_email, _password);
        setState(() {
         loading= false;
        });
      }
    } catch (e) {

      print(e.toString());
      showDialog(context:  context , builder: ( context){
        return AlertDialog(
          title: Text( 'signin failed'),
          content:Text( e.toString()),  
          actions: [
             FlatButton(onPressed:    (){
               Navigator.of(context).pop();
             },  child:  Text( 'ok'))
          ],
        );
      }  );

    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _emaileditingcomplete() {
    FocusScope.of(context).requestFocus(_passwordfocusnode);
  }

  updatestate() {
    setState(() {});
  }

  //functionsection

  List<Widget> _buildchilderen() {
    final primmarytext =
        _formtype == Signinformtype.signin ? 'sign In' : 'create an Account';
    final secondarytext = _formtype == Signinformtype.signin
        ? 'need an acoount register'
        : 'have an acoounnt signIn';
    bool _submitenabled = widget.emailvallidator.isvalid(_email) &&
        widget.passvallidator.isvalid(_password) &&
        !_isloading;
    _email.isNotEmpty && _password.isNotEmpty;
    bool showeerortext_emailvalid =
        submited && !widget.emailvallidator.isvalid(_email);
    bool showerror_passvalid =
        submited && !widget.passvallidator.isvalid(_password);
    return [
      TextField(
        enabled: _isloading == false,
        onChanged: (pass) => updatestate(),
        focusNode: _emailfocusnode,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'text@gmail.com',
            errorText: showeerortext_emailvalid ? widget.errorpass : null),
        textInputAction: TextInputAction.next,
        controller: emailconroller,
        onEditingComplete: _emaileditingcomplete,
      ),
      TextField(
        enabled: _isloading == false,
        onChanged: (pass) => updatestate(),
        focusNode: _passwordfocusnode,
        controller: passcontroller,
        decoration: InputDecoration(
            labelText: 'Password',
            errorText: showerror_passvalid ? widget.errorpass : null),
        textInputAction: TextInputAction.done,
        obscureText: true,
      ),
      RaisedButton(
        color: Colors.indigo,
        child: Text(
          primmarytext,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: _submitenabled ? submit : null,
      ),
      FlatButton(
        child: Text(secondarytext),
        onPressed: !_isloading ? toggleform : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<Emailsigininmodel >(
      stream:widget. ,
      builder: (context, snapshot) {
        return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildchilderen(),
            ),
          );
      }
    );

  }
}
