import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:sizer/sizer.dart';

class RoundButton extends StatelessWidget {
  IconData icon;
  final void Function() onPress;

  RoundButton({required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: this.onPress,
      child: Icon(icon, color: kPresentTheme.themeColor),
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 10.w,
        height: 10.h,
      ),
      shape: CircleBorder(),
      fillColor: kPresentTheme.accentColor,
    );
  }
}
