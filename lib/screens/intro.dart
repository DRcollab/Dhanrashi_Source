import 'dart:async';

import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login_screen.dart';


class Intro extends StatefulWidget {
  Intro({ required this.nav});

  Widget nav;
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 2),
        (){
         // Navigator.pop(context);


            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (context,a1,a2) =>
                    widget.nav,
                    transitionsBuilder: (context,anim,a1,child) => FadeTransition(opacity: anim,child: child,),
                    transitionDuration: Duration(milliseconds: 3000),

                ));



        }
    );

    return Scaffold(

      body: Container(
        color: kPresentTheme.accentColor,
        child:Center(child: Image.asset('${DefaultValues.imageDirectory}${DefaultValues.introImage}')),

      ),

    );
  }
}
