
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/profile_access.dart';
import 'package:dhanrashi_mvp/data/validators.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'components/constants.dart';
import 'package:sizer/sizer.dart';

import 'components/on_error_screen.dart';
import 'landing.dart';
import 'login_screen.dart';
import 'models/profile.dart';
import 'profiler.dart';
import 'signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data/user_handler.dart';
import 'data/database.dart';
import 'components/custom_text.dart';
import 'models/user_data_class.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:firebase_core/firebase_core.dart';

class ResetScreen extends StatefulWidget with InputValidationMixin {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen>  with InputValidationMixin{

  var _emailKey = GlobalKey<FormState>();
  late FirebaseAuth fireAuth;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// Instantiate a Firebase auth object
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);

  }


  void _reset(String email) async {


      await fireAuth.sendPasswordResetEmail(email: emailController.text).whenComplete(() {
        Utility.showMessageAndAsk(
            context:context,
            msg:'An Email has been sent to your registered email ${emailController.text} with a link to reset password',
            takeAction: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
        );

      }
      );

      //     .catchError((onError){
      //   Utility.showErrorMessage(context, onError.toString());
      // });



  }

  @override
  void dispose(){


    super.dispose();
  }

  var emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.monetization_on),
              Text('Dhanrashi', style:DefaultValues.kH1(context),),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w,right:4.w,top:4.h,bottom:2.h),
            child: InputCard(
              titleText: "Reset Login Page",
              children: [
                //Logger(),
                Column(

                  children: [
                    Padding(
                      padding:DefaultValues.kTextFieldPadding(context),
                      child: Form(
                        key: _emailKey,

                        child: CustomTextField(

                          controller: emailController,
                          icon: Icons.email,
                          validator: (value){
                            if(eMailValid(value.toString()))
                              return null;
                            else
                              return validEmailMessage;
                          },
                          hintText: 'Enter Login Name/ email',
                        ),
                      ),
                    ),
                    Padding(
                      padding:DefaultValues.kTextFieldPadding(context),
                      child: CommandButton(

                        buttonColor: kPresentTheme.accentColor,
                        borderRadius: BorderRadius.circular(DefaultValues.kCurveRadius),
                        buttonText: 'Reset Password',
                        textColor: kPresentTheme.lightWeightColor,
                        textSize: 12.sp,
                        onPressed: () {

                          setState(() {

                            if(_emailKey.currentState!.validate()){

                              // TODO code to send user password reset link //
                              // var currentUser = DRUserAccess(fireAuth).createUser(email, password)
                              _reset(emailController.text);
                            }

                          });



                        },
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding:DefaultValues.kTextFieldPadding(context),
                  child: LinkText(
                      type: LinkTextType.DARK,
                      linkText: "Recalled the password ? Go back",
                      displaySize: 12.sp,

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                        )
                        );
                      }

                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Not have a login id ?",
                  style:DefaultValues.kNormal2(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommandButton(
                  buttonText: "Click Here to Sign Up",
                  borderRadius: BorderRadius.circular(DefaultValues.kCurveRadius),
                  buttonColor: kPresentTheme.alternateColor,
                  textColor: kPresentTheme.accentColor,

                  //type: LinkTextType.DARK,
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calculator),
            label: 'SIP Calculator',

          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chartBar),
              label: 'Inflation Data'
          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.wrench),
              label: 'Settings'
          ),
        ],
      ),

    );
  }
}
