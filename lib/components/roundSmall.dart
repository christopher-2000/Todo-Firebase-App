import 'package:flutter/material.dart';
import 'package:todofirebase/components/theme_color.dart';
//import 'package:flutter_auth/constants.dart';

class RoundSmall extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width;
  const RoundSmall({
    Key key,
    this.text,
    this.press,
    this.width,
    this.color = primayColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
