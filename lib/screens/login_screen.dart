import 'dart:core';
import 'package:dhanrashi_mvp/components/vanish_keyboard.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/profile_access.dart';
import 'package:dhanrashi_mvp/data/validators.dart';
import 'package:dhanrashi_mvp/screens/profiler_option_page.dart';
import 'package:dhanrashi_mvp/screens/reset_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import '../components/buttons.dart';
import '../components/custom_card.dart';
import '../components/custom_scaffold.dart';
import '../components/constants.dart';
import 'package:sizer/sizer.dart';
import '../models/profile.dart';
import 'signup_page.dart';
import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../data/user_handler.dart';
import '../data/database.dart';
import '../components/custom_text.dart';

import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget with InputValidationMixin {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  bool profileReady =
  false; // will be used to determine if profiler page to be navigated or to fiwi
  //DRUserAccess? currentUser; // Store the  Name of the user (not user id) if users decides not fill in name then user id will be used//
  // The currentUser will be displayed on fiwi or other places....

  // bool useForReset = false;

  int cardIndex = 0;
  late final _loggedInUser;
  String _errorText = "";
  late final _userText;
  late final _passWord;
  late final _loginKey; // = GlobalKey<FormState>(); // Used for user email validation
  late final _passwordKey; // = GlobalKey<FormState>(); // Used fot password validation
  late AutovalidateMode _autovalidateMode;
  var _user = UserHandeler(userTable, userProfileTable);

  bool clickedLogin = false;
  bool loginState = false;
  // late DRUserAccess currentUser;

  late FirebaseAuth fireAuth;
  late FirebaseFirestore fireStore;
  late DRProfileAccess profileAccess;
  bool _hidePassword = true;
  late Profile profile;
  late SharedPreferences prefs;

  int whichTextBoxClickedOn = -1;

  /// Goto Logger class definition to see how login is happening
  ///
  @override
  void dispose() {
    _userText.dispose();
    _passWord.dispose();
    if (_loginKey.currentState != null) _loginKey.currentState.dispose();

    if (_passwordKey.currentState != null) _passwordKey.currentState.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _loginKey = GlobalKey<FormState>();
    _passwordKey = GlobalKey<FormState>();
    _userText = TextEditingController();
    _passWord = TextEditingController();
    profile = Profile.create();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
    future:
    initPrefs();
    future:
    Firebase.initializeApp().whenComplete(() {
      fireAuth = FirebaseAuth.instance;
      fireStore = FirebaseFirestore.instance;
    });
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // This async method implements login
  void _login(String id, String pwd) async {
    try {
      var _loggedInUser =
      await fireAuth.signInWithEmailAndPassword(email: id, password: pwd);
      if (_loggedInUser.user != null) {
        profile.uid = _loggedInUser.user!.uid;
        profile.email = _loggedInUser.user!.email!;

        prefs.setBool('session_active', true);
        prefs.setString('user_id', _loggedInUser.user!.uid);
        prefs.setString('email', _loggedInUser.user!.email!);

        fireStore
            .collection('pjdhan_users')
            .where('Uid', isEqualTo: _loggedInUser.user!.uid)
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isEmpty) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilerOptionPage(
                      currentUser: profile,
                    )));
          }

          /// on successful retrieving of user details
          snapshot.docs.forEach((f) {
            String email = f.get('email');
            String userID = f.get('Uid');
            String docID = f.id;
            String firstName = f.get('first_name');
            String lastName = f.get('last_name');
            Timestamp dob = f.get('DOB');
            String incomeRange = f.get('income');
            String image = f.get('image_source');

            /// Updating profile of user in a profile class object
            /// This profile object will be sent to all widget and screens
            profile = Profile(
              firstName: firstName,
              lastName: lastName,
              DOB: dob.toDate(),
              incomeRange: incomeRange,
              docId: docID,
              uid: userID,
              email: email,
              profileImage: '${DefaultValues.directoryOfPhoto}/$image',
            );

            /// Populating shared preference prefs which will be used to determine whether user is logged
            prefs.remove('f_name');
            prefs.setString('f_name', firstName);
            prefs.remove('l_name');
            prefs.setString('l_name', lastName);
            prefs.remove('dob');
            prefs.setString('dob', dob.toDate().toString());
            prefs.remove('income');
            prefs.setString('income', incomeRange);
            prefs.remove('doc_id');
            prefs.setString('doc_id', docID);
            prefs.remove('image');
            prefs.setString(
                'image', '${DefaultValues.directoryOfPhoto}/$image');

            /// If user details is FOUND for the user then redirected to the Dashboard...
            if (profile.docId != '') {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                        currentUser: profile, //_loggedInUser.user,
                      )));
            }
          });
        }).catchError((e) {
          setState(() {
            clickedLogin = false;
          });

          throw e;
        });
      } else {
        setState(() {
          clickedLogin = false;
        });
      }
    } catch (e) {
      setState(() {
        clickedLogin = false;
      });
      Utility.showErrorMessage(context, Utility.customise(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return VanishKeyBoard(
        onTap: () {
          switch (whichTextBoxClickedOn) {
            case 0:
              _loginKey.currentState!.validate();
              break;
            case 1:
              _passwordKey.currentState!.validate();
              break;
          }
        },
        child: CustomScaffold(
          rightButton: SizedBox(),
          leftButton: SizedBox(),
          child: ListView(
            children: [
              Padding(
                padding: DefaultValues.kAdaptedTopPadding(context, 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                       DefaultValues.setLogo(context),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 4.w, right: 4.w, top: 4.h, bottom: 2.h),
                      child: InputCard(
                        titleText: DefaultValues.titles['login_page_title']!,
                        children: [
                          //Logger(),
                          Column(
                            children: [
                              Padding(
                                  padding:
                                  DefaultValues.kTextFieldPadding(context),
                                  child: Form(
                                    key: _loginKey,
                                    child: CustomTextField(
                                      autovalidateMode: this._autovalidateMode,
                                      controller: _userText,

                                      hintText: DefaultValues.hints['email']!,
                                      passWord: false,
                                      icon: Icons.email,
                                      //  textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (eMailValid(value.toString()))
                                          return null;
                                        else
                                          return validEmailMessage;
                                      },
                                      onSubmit: () {
                                        _loginKey.currentState!.validate();
                                      },
                                      validate: () {
                                        setState(() {
                                          if (_errorText != '') {
                                            _errorText = '';
                                          }

                                          if (whichTextBoxClickedOn == 1) {
                                            _passwordKey.currentState!
                                                .validate();
                                          }
                                          whichTextBoxClickedOn = 0;
                                        });
                                      },
                                    ),
                                  )),
                              Padding(
                                padding:
                                DefaultValues.kTextFieldPadding(context),
                                child: Form(
                                  key: _passwordKey,
                                  child: CustomTextField(
                                    onSubmit: () {},
                                    // textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (passWordValid(value.toString()))
                                        return null;
                                      else
                                        return validPasswordMessage;
                                    },

                                    validate: () {
                                      setState(() {
                                        if (_errorText != '') {
                                          _errorText = '';
                                        }
                                        if (whichTextBoxClickedOn == 0) {
                                          _loginKey.currentState!.validate();
                                        }
                                        whichTextBoxClickedOn = 1;
                                      });
                                    },

                                    controller: _passWord,
                                    hintText: DefaultValues.hints['pwd']!,
                                    passWord: true,
                                    hidePassword: _hidePassword,
                                    icon: Icons.password_sharp,
                                    showPassword: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                    // key: _passKey,
                                  ),
                                ),
                              ),
                              ErrorText(
                                errorText: _errorText,
                              ),
                              !clickedLogin
                                  ? CommandButton(
                                buttonText: DefaultValues
                                    .titles['login_button_text']!,
                                textSize: 12
                                    .sp, // * DefaultValues.adaptForSmallDevice(context),
                                buttonColor: kPresentTheme.accentColor,
                                textColor: kPresentTheme.lightWeightColor,
                                borderRadius: BorderRadius.circular(
                                    DefaultValues.kCurveRadius),
                                onPressed: () {
//
                                  setState(() {
                                    if (_loginKey.currentState!
                                        .validate()) {
                                      if (_passwordKey.currentState!
                                          .validate()) {
                                        clickedLogin = true;
                                        // Async function to enable login

                                        try {
                                          _login(_userText.text,
                                              _passWord.text);
                                        } catch (e) {
                                          Utility.showErrorMessage(
                                              context, e.toString());
                                        }
                                      } // end of outside
                                    }
                                  });
                                  //circularProgressIndicator
                                },
                              )
                                  : Image.asset(
                                kPresentTheme.progressIndicator,
                                scale: 3,
                              ),
                            ],
                          ),
                          Padding(
                            padding: DefaultValues.kTextFieldPadding(context),
                            child: LinkText(
                                type: LinkTextType.DARK,
                                linkText:
                                DefaultValues.messages['login_link_text']!,
                                displaySize: 12
                                    .sp, //*  DefaultValues.adaptForSmallDevice(context),

                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResetScreen(),
                                      ));
                                }),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "",
                            style: DefaultValues.kNormal2(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.h),
                          child: CommandButton(
                            textSize: 12
                                .sp, // * DefaultValues.adaptForSmallDevice(context),
                            buttonText: DefaultValues.titles['signup_option']!,
                            borderRadius: BorderRadius.circular(20),
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
              ),
            ],
          ),
          showBottomNavBar: false,
          //bottomNavigationBar: SizedBox(),
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
    });
  }
}