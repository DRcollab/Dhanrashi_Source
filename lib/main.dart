import 'package:dhanrashi_mvp/confirmation_page.dart';
import 'package:dhanrashi_mvp/data/user_data_class.dart';
import 'package:dhanrashi_mvp/empty_page_inputs.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
//import 'package:dhanrashi_mvp/goalinput.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:dhanrashi_mvp/showgraph_dynamic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'components/theme_class.dart';
import 'data/filemanagr_class.dart';
import 'investmentinput.dart';
//import 'goalinput.dart';
import 'login_page.dart';
import 'profiler.dart';
import 'signup_page.dart';
import 'test.dart';
import 'package:flutter/material.dart';
//import 'goalinput.dart';
import 'investmentinput.dart';
import 'dashboard_old.dart';
import 'constants.dart';
import 'package:dhanrashi_mvp/goal_input.dart';

UserData currentUser = UserData('', '_fName', '_lName', '_dob', '_income');


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //  statusBarColor: Colors.transparent,

      statusBarIconBrightness: Brightness.dark));
      runApp(
          MultiProvider(
              providers: [ChangeNotifierProvider(create: (_)=>FileController())],
              child:  DhanrashiMVP(),
          )


      );
}

class DhanrashiMVP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<FileController>().readSettings();
  // kPresentTheme = context.select((FileController controller) => controller.settings !=null ? controller.settings.theme:kPresentTheme);
    return MaterialApp(
      title: 'Flutter Demo',
   //    routes: {
   //      '/': (context) => LoginPage(),
   //      '/profiler_opt': (context) => ProfilerOptionPage(currentUser: currentUser,),
   //      '/profiler': (context) => ProfilerPage(currentUser: currentUser),
   // //     '/profiler_confirm':(context) => ConfirmationPage(collector: collector, currentUser: currentUser)
   //    },

      //home:ProfilerPage(currentUser: currentUser),
      home:LoginPage(),
      //home:InvestmentScreen(),
    );
  }
}

