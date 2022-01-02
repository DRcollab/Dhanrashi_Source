

import 'package:dhanrashi_mvp/components/vanish_keyboard.dart';
import 'package:dhanrashi_mvp/data/database.dart';

import 'package:dhanrashi_mvp/data/user_handler.dart';
import 'package:dhanrashi_mvp/data/validators.dart';

import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:dhanrashi_mvp/tnc.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'components/constants.dart';

import 'package:flutter/material.dart';
import 'components/custom_text_field.dart';

import 'components/custom_text.dart';
import 'login_screen.dart';
import 'models/profile.dart';
import 'data/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/utilities.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:sizer/sizer.dart';


// var  TEXTFIELD_PADDING = EdgeInsets.fromLTRB(
//     18.0 *  DefaultValues.adaptForSmallDevice(context),
//     18.0 * DefaultValues.adaptForSmallDevice(context),
//     18.0 *DefaultValues.adaptForSmallDevice(context),
//
//     8.0 *DefaultValues.adaptForSmallDevice(context),
// );



  class SignUpPage extends StatefulWidget with InputValidationMixin {

  //const Logging({Key? key}) : super(key: key);

 // var currentUser;

   // SignUpPage({});

  @override
  _SignUpState createState() => _SignUpState();
  }

  class _SignUpState extends State<SignUpPage> with InputValidationMixin{

    bool buttonClicked = false;
    bool _hidePassword = true;
    bool _hidePassword2 = true;
    bool _agreedToTnc = false;

  final _userEmail = TextEditingController();
  final  _userPassword = TextEditingController();
  final _userPassword2 = TextEditingController();
  var _errorText="";

  var _emailKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormState>();
  var _passKey2 = GlobalKey<FormState>();

    int whichTextBoxClickedOn = -1;

  var _user = UserHandeler(userTable, userProfileTable);

  late FirebaseAuth fireAuth;
  Profile profile = Profile.create();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);
  }

  void _createUser(String id, String pwd) async {
    try{

      var currentUser = await fireAuth.createUserWithEmailAndPassword(email: id, password: pwd) ;
      if(currentUser.user !=null){
        profile.uid = currentUser.user!.uid;
        profile.email = currentUser.user!.email!;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfilerOptionPage(currentUser: profile,)));

      }

    }catch(e){
      setState(() {
        this.buttonClicked = false;
      });
      Utility.showErrorMessage(context, e.toString());
    }



  }




  @override
  Widget build(BuildContext context) {
    return VanishKeyBoard(
      onTap: () {

        switch (whichTextBoxClickedOn) {
          case 0:
            _emailKey.currentState!.validate();
            break;
          case 1:
            _passKey.currentState!.validate();
            break;
          case 2:
            _passKey2.currentState!.validate();
            break;
        }

      },
      child: CustomScaffold(
        rightButton: SizedBox(),
        leftButton: SizedBox(),
        child: ListView(
          children: [
            Padding(
              padding: DefaultValues.kAdaptedTopPadding(context, 8.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on),
                      Text(DefaultValues.titles['app_name']!, style:DefaultValues.kH1(context),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w,right:4.w,top:4.h,bottom:2.h),
                    child: InputCard(
                      mainAxisAlignment: MainAxisAlignment.center,
                      titleText: DefaultValues.titles['signup_title']!,
                      children: [
                        Padding(
                          padding:EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.w),// DefaultValues.kTextFieldPadding(context),
                          child: Form(
                            key: _emailKey,
                            child: CustomTextField(
                              onSubmit: (){
                                _emailKey.currentState!.validate();
                              },
                              controller: _userEmail,

                              validate: (){
                                setState(() {

                                  if(whichTextBoxClickedOn==1){
                                    _passKey.currentState!.validate();
                                  }else{
                                    if(whichTextBoxClickedOn==2){
                                      _passKey2.currentState!.validate();
                                    }
                                  }

                                  whichTextBoxClickedOn = 0;
                                  _errorText = "";
                                });
                              },


                              validator: (value) {
                                if (eMailValid(value.toString()))
                                  return null;
                                else
                                  return validEmailMessage;
                              },

                              icon: Icons.email,
                              hintText: DefaultValues.hints['email_signup']!,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.w),
                          child: Form(
                            key: _passKey,
                            child: CustomTextField(
                              showPassword: (){
                                setState(() {

                                  _hidePassword = !_hidePassword;
                                });
                              },
                              onSubmit: (){
                                _passKey.currentState!.validate();
                              },
                              controller: _userPassword,

                              validate: (){
                                setState(() {
                                  if(whichTextBoxClickedOn==0){
                                    _emailKey.currentState!.validate();
                                  }else{
                                    if(whichTextBoxClickedOn==2){
                                      _passKey2.currentState!.validate();
                                    }
                                  }

                                  whichTextBoxClickedOn = 1;

                                  _errorText = "";
                                });
                              },

                              validator: (value){
                                if(passWordValid(value.toString()))
                                  return null;
                                else
                                  return validPasswordMessage;
                              },
                              icon: Icons.password_rounded,
                              hidePassword: _hidePassword,
                              hintText: DefaultValues.hints['pwd']!,
                              passWord: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.w),
                          child: Form(
                            key: _passKey2,
                            child: CustomTextField(
                              showPassword: (){
                                setState(() {
                                  _hidePassword2 = !_hidePassword2;
                                });
                              },
                              onSubmit: (){
                                _passKey2.currentState!.validate();
                              },
                              controller: _userPassword2,
                              hidePassword: _hidePassword2,
                              validate: (){
                                setState(() {

                                  if(whichTextBoxClickedOn==0){
                                    _emailKey.currentState!.validate();
                                  }else{
                                    if(whichTextBoxClickedOn==1){
                                      _passKey.currentState!.validate();
                                    }
                                  }
                                  whichTextBoxClickedOn = 2;
                                  _errorText = "";
                                });
                              },


                              validator: (value){
                                if(_userPassword.text == _userPassword2.text){
                                  return null;

                                }
                                else
                                  return DefaultValues.errors['not_match']!;
                              },
                              icon: Icons.password_sharp,
                              hintText: DefaultValues.hints['re_pwd']!,
                              passWord: true,
                            ),
                          ),
                        ),
                        ErrorText(errorText: _errorText,), //from custom_text
                        buttonClicked ?  Image.asset(kPresentTheme.progressIndicator, scale: 3,
                        ):CommandButton(
                          enabled: this._agreedToTnc,
                          textColor: kPresentTheme.lightWeightColor,
                          buttonColor: kPresentTheme.accentColor,
                          buttonText: DefaultValues.titles['signup_button_text']!,
                          textSize: 12.sp,
                          borderRadius: BorderRadius.circular(DefaultValues.kCurveRadius),
                          onPressed: () {


                            setState(() {

                              if(_emailKey.currentState!.validate()){
                               if(_passKey.currentState!.validate()){
                                 if(_passKey2.currentState!.validate()){

                                   /// creates an user in the firebase.
                                   this.buttonClicked = true;
                                      _createUser(_userEmail.text, _userPassword.text);
                                      Global.goalCount = 0;
                                      Global.investmentCount = 0;

                                 }

                               }

                              }
                              else
                                Utility.showErrorMessage(context, DefaultValues.errors['anonymous']!);
                            /// custom method defined in utilities.dart;
                            });
                          },
                        ),
                        Row(
                          children : [
                            Padding(
                              padding: EdgeInsets.only(left:6.w),
                              child: Checkbox(
                                value: this._agreedToTnc,
                                onChanged: (value){
                                  setState(() {
                                    this._agreedToTnc = value!;
                                  });

                                },

                              ),
                            ),
                            Text(DefaultValues.messages['tnc']!, style: TextStyle(fontSize: 18.0),),
                            LinkText(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TnC(),
                                    )
                                );
                              },
                              linkText: DefaultValues.messages['tnc_link_text']!,
                              displaySize: 12.sp,

                            )

                          ]
                        )


                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DefaultValues.messages['ask_for_login']!,
                          style:DefaultValues.kNormal2(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommandButton(
                          buttonText: DefaultValues.titles['ask_login_button_text']!,
                          buttonColor: kPresentTheme.alternateColor,
                          textColor: kPresentTheme.accentColor,
                          textSize: 12.sp,
                          borderRadius: BorderRadius.circular(20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(),
        // BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.calculator,size: 15.sp,),
        //       label: 'SIP Calculator',
        //
        //     ),
        //     BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chartBar,size: 15.sp,),
        //         label: 'Inflation Data'
        //     ),
        //     BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.wrench,size: 15.sp,),
        //         label: 'Settings'
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
