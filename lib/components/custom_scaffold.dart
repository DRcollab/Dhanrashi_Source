import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScaffold extends StatelessWidget {
  Widget child;
  //final Widget svg = Svg

  CustomScaffold({this.child});


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
       statusBarColor: Color(0xffb5c210),
        systemNavigationBarIconBrightness: Brightness.dark,
       // systemNavigationBarColor: Colors.black,
      ) ,

      child: Scaffold(
        resizeToAvoidBottomInset: false,

       // backgroundColor: kPresentTheme.scaffoldColors[0],

        body: CustomPaint(
          painter: CurvePainter(type:1),
            child: SafeArea(child: this.child)),
      ),
    );
  }
}
