enum Signinformtype { signin, register }

class Emailsigininmodel {
  Emailsigininmodel( {
    this.password=' ',
    this.email='',
    this.formtype =Signinformtype.signin,
    this.islaoding  = false       ,
    this.submitted = false,
  } );

  final String password  ;
  final String email;
  final Signinformtype formtype;
  final bool islaoding;
  final bool submitted;

  Emailsigininmodel Copywith({
    String password  ,
    String email,
    Signinformtype formtype,
    bool islaoding,
    bool submitted,
  }) {
    return Emailsigininmodel(
      email: email??this.email,
      password: password??this.password,
      formtype:formtype??this. formtype,
      submitted:submitted ??this.submitted,
        ) ;
  }
}
