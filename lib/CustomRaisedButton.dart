  import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  final Widget child;
  final Color color;
  final double  borderRadious ;
  final VoidCallback  onpressed;



  const CustomRaisedButton({Key key, this.color, this.borderRadious:10.0,  this.onpressed, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return  SizedBox(
     height: 50.0,
     child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadious)
          ),
          color: color,
          child: child,



          onPressed:   onpressed),
   );
  }
}
