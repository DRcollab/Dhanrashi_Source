import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:dhanrashi_mvp/showgraph_dynamic.dart';
import 'package:flutter/services.dart';
import 'investmentinput.dart';
import 'goalinput.dart';
import 'login_page.dart';
import 'profiler.dart';
import 'signup_page.dart';
import 'test.dart';
import 'package:flutter/material.dart';
import 'goalinput.dart';
import 'investmentinput.dart';
import 'dashboard.dart';
import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //  statusBarColor: Colors.transparent,

      statusBarIconBrightness: Brightness.dark));
  runApp(DhanrashiMVP());
}

class DhanrashiMVP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home:InvestmentInputScreen(),
    );
  }
}

