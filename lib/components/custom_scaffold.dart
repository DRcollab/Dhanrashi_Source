import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhanrashi_mvp/components/menu_drawer_class.dart';

class CustomScaffold extends StatelessWidget {
  Widget child;
  //final Widget svg = Svg

  CustomScaffold({required this.child});

  final  _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
       statusBarColor: Color(0xffb5c210),
        systemNavigationBarIconBrightness: Brightness.dark,
       // systemNavigationBarColor: Colors.black,
      ) ,

      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,

       // backgroundColor: kPresentTheme.scaffoldColors[0],

        body: CustomPaint(
          painter: CurvePainter(type:1),
            child: SafeArea(
                child: Stack(
                  children: [
                    this.child,
                    Padding(
                      padding: const EdgeInsets.only(left:8),
                      child: GestureDetector(
                        onTap: () {

                          _scaffoldKey.currentState!.openDrawer();
                          },

                        child: Icon(Icons.menu),
                        //CircleAvatar(radius: 20,backgroundColor: Colors.amber,


                        ),
                      ),
                    //),

                  ],
                ),
            ),

        ),
        drawer: MenuDrawer(),
      ),
    );
  }
}
