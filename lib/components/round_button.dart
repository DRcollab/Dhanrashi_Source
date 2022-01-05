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


class ExpandButton extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  Widget display;
  Function()? onTap;

  ExpandButton({
      this.width = 30,
      this.height = 30,
      this.color = const Color(0x00000000),
     this.display = const Icon(Icons.keyboard_arrow_up),
      //required this.display,
      required this.onTap,
        });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 14.0),
          child: this.display,
        ),
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color:Colors.black26,
            spreadRadius: 0.5,
            blurRadius: 1.0,
            offset: Offset(0,-3),
          ),


          ]
        ),
      ),
    );
  }


}


class Placard extends StatelessWidget {

  String text;
  Color color;
  Widget child;

  Placard({
    this.text = '',
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: this.child,
      ),
      decoration: BoxDecoration(
        color:this.color,
        borderRadius: BorderRadius.circular(10),
      )
    );
  }
}
