
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_traveller/Signin_model.dart';

import 'package:time_traveller/auth.dart';
import 'package:time_traveller/emailsignin_block.dart';
import 'package:time_traveller/vallidator.dart';


class Emailsign_formBloc_based extends StatefulWidget
    with EmailandpasswordVallidators {
  Emailsign_formBloc_based({@required this.bloc});

  final EmailSigninblock bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<Authbase>(context, listen: false);
    return Provider<EmailSigninblock>(create: (_) => EmailSigninblock(auth),
      child: Consumer<EmailSigninblock>(
          builder: (_, bloc, __) => Emailsign_formBloc_based(bloc: bloc)),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _Emailsign_formBloc_basedState createState() =>
      _Emailsign_formBloc_basedState();

}

class _Emailsign_formBloc_basedState extends State<Emailsign_formBloc_based> {

  Signinformtype _formtype = Signinformtype.signin;
  final TextEditingController emailconroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final FocusNode _emailfocusnode = FocusNode();
  final FocusNode _passwordfocusnode = FocusNode();


  void toggleform(Emailsigininmodel model) {
      widget.bloc.UpdateWith(
        is_submitted:  false,
        Formtype: model.formtype ==Signinformtype.signin
            ? Signinformtype.register
            : Signinformtype.signin,
      );


  }

  void submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context ).pop();
    } catch (e) {
      print(e.toString());
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('signin failed'),
          content: Text(e.toString()),
          actions: [
            FlatButton(onPressed: () {
              Navigator.of(context).pop();
             }, child: Text('ok'))
          ],
        );
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

  List<Widget> _buildchilderen(Emailsigininmodel model ) {

    final primmarytext =
    _formtype == Signinformtype.signin ? 'sign In' : 'create an Account';
    final secondarytext = _formtype == Signinformtype.signin
        ? 'need an acoount register'
        : 'have an acoounnt signIn';
    bool _submitenabled = widget.emailvallidator.isvalid(model.email) &&
        widget.passvallidator.isvalid(model.password) &&
        !model.islaoding   ;
    model.email.isNotEmpty && model.password.isNotEmpty;
    bool showeerortext_emailvalid =
        model.submitted && !widget.emailvallidator.isvalid(model.email);
    bool showerror_passvalid =
        model.submitted  && !widget.passvallidator.isvalid(model.password );
    return [
      TextField(
        enabled:model.islaoding == false,
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
        enabled:model.islaoding  == false,
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

    ];
  }

  @override
  Widget build(BuildContext context) {
    return

      StreamBuilder<Emailsigininmodel>(
          stream: widget.bloc.modelstream,
          builder: (context, snapshot) {
            final Emailsigininmodel model = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: _buildchilderen(model),
              ),
            );
          }
      );
  }







}
