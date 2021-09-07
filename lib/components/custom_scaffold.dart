import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhanrashi_mvp/components/menu_drawer_class.dart';

class CustomScaffold extends StatelessWidget {
  Widget child;
  String title = '';
  Widget? trailing;
  late Widget body;
  Widget? bottomNavigationBar;
  var currentUser;
  //final Widget svg = Svg

  CustomScaffold({
    required this.child,
    this.title = '',
    this.trailing,
    this.body = const SizedBox(height: 0,width: 0,),
    this.bottomNavigationBar = const  SizedBox(height: 0, width: 0,),
    this.currentUser,
  });

  final  _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
       statusBarColor: kPresentTheme.themeColor,//Color(0xffb5c210),
        systemNavigationBarIconBrightness: Brightness.dark,
       // systemNavigationBarColor: Colors.black,
      ) ,

      child: Scaffold(

        backgroundColor: kPresentTheme.themeColor,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,

       // backgroundColor: kPresentTheme.scaffoldColors[0],

        body: SafeArea(
            child: Stack(
              children: [
                this.child,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Text(this.title),
                    Padding(
                      padding: const EdgeInsets.only( right:8.0),
                      child: Icon(Icons.account_circle_sharp),
                    ),
                  ],
                ),
                //),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: this.body,
                ),
              ],
            ),
        ),
        drawer: MenuDrawer(currentUser: this.currentUser, ),
        bottomNavigationBar:bottomNavigationBar,
      ),
    );
  }
}
