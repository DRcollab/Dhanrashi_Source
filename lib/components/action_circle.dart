import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';

class ActionCircle extends StatelessWidget {

 Color color;
 int index= 0;
 int selectedIndex = 0;
 double radius = 40 ;
 Function onPreseed;
String imageSource = '';

 ActionCircle({
   this.color = Colors.white70,
  required this.index,
  this.selectedIndex = 0,
  this.radius = 40.0,
  required this.onPreseed,
   this.imageSource = 'images/profile_image'
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        this.onPreseed();
      },

      child: CircleAvatar(
        backgroundColor: kPresentTheme.themeColor,
        radius:  this.radius * DefaultValues.adaptForSmallDevice(context),
        backgroundImage:AssetImage(imageSource),
      ),
    );
  }
}
