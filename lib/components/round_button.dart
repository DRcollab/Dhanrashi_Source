import 'package:flutter/material.dart';
import '../constants.dart';

class RoundButton extends StatelessWidget {
  IconData icon;
  Function onPress;

  RoundButton({this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: this.onPress,
      child: Icon(icon, color: kLightTextColor),
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 40,
        height: 40,
      ),
      shape: CircleBorder(),
      fillColor: kDarkButtonColor,
    );
  }
}
