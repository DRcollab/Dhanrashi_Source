

import 'package:dhanrashi_mvp/data/validators.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'constants.dart';
import 'dashboard_old.dart';
import 'profiler.dart';
import 'signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data/user_handler.dart';
import 'data/database.dart';
import 'components/custom_text.dart';
import 'data/user_data_class.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:firebase_core/firebase_core.dart';


class LoginPage extends StatefulWidget {

//UserData currentUser = UserData.create();

DRUserAccess? currentUser;

LoginPage({this.currentUser});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with InputValidationMixin{

   bool profileReady = false; // will be used to determine if profiler page to be navigated or to dhanrashi
    DRUserAccess? currentUser; // Store the  Name of the user (not user id) if users decides not fill in name then user id will be used//
  // The currentUser will be displayed on dhanrashi or other places....

  final _userText = TextEditingController();
  final _passWord = TextEditingController();
  var _userKey = GlobalKey<FormState>(); // Used for user email validation
  var _passKey = GlobalKey<FormState>(); // Used fot password validation
  int cardIndex = 0;


   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     currentUser = widget.currentUser;




   }

  @override
  void dispose(){
    _userText.dispose();
    _passWord.dispose();
    super.dispose();
  }



  final List<Widget> cardView = [
   Logger(),
    Resetter(),
  ];

  final List<String> titleText = [
    "Login Page",
    "Reset Login Page",
  ];

  final List<String> linkText = [
    "Trouble login ? Click here to resolve",
    "Recalled the password ? Go back",
  ];



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
              Text('Dhanrashi', style: kH1,),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0,right:18.0,top:28.0,bottom:18),
          child: InputCard(
          titleText: titleText[cardIndex],
          children: [
            cardView[cardIndex],
            Padding(
              padding: kTextFieldPadding,
              child: LinkText(
                  type: LinkTextType.DARK,
                  linkText: linkText[cardIndex],
                  displaySize: 18.0,

                  onPressed: () {
                    setState(() {

                      if(cardIndex == 0)
                            cardIndex = 1;
                      else
                        cardIndex = 0;
                    });

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
                  "Not have a login id ?",
                  style: kNormal2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommandButton(
                  buttonText: "Click Here to Sign Up",
                  borderRadius: BorderRadius.circular(20),
                  buttonColor: kPresentTheme.alternateColor,
                  textColor: kPresentTheme.accentColor,

                  //type: LinkTextType.DARK,
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(currentUser: widget.currentUser,),
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

// Logging provides screen for login screen with two textfield
// 1. login id  or email
// 2. password.






class Logger extends StatefulWidget with InputValidationMixin {

 // DRUserAccess? currentUser;
  Logger();




  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> with InputValidationMixin {


   bool _profileReady = false; // will be used to determine if profiler page to be navigated or to dhanrashi
  //final String currentUser = ""; // Store the  Name of the user (not user id) if users decides not fill in name then user id will be used//
  // The currentUser will be displayed on dhanrashi or other places....

   late final _loggedInUser;
  String _errorText = "";
  final _userText = TextEditingController();
  final _passWord = TextEditingController();
  var _userKey = GlobalKey<FormState>(); // Used for user email validation
  var _passKey = GlobalKey<FormState>(); // Used fot password validation

  var _user = UserHandeler(userTable, userProfileTable);
  //var _userProfile = UserHandeler(userProfileTable);

   bool loginState = false;
  // late DRUserAccess currentUser;

   late FirebaseAuth fireAuth ;
  bool _hidePassword = true;

  @override
  void dispose(){
    _userText.dispose();
    _passWord.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);

  }

  // This async method implements login
   void _login(String id, String pwd) async {
     //currentUser = DRUserAccess(fireAuth);
    //_loggedInUser
     var _loggedInUser = await DRUserAccess(fireAuth).authUser(id, pwd);

     if (_loggedInUser != null) {

       _profileReady = _user.fetchProfile(); // preserved for fetching user profile.

       if (_profileReady){
         Navigator.push(context,
             MaterialPageRoute(builder: (context) => DashBoard(currentUser: _user.user(),)));
       }
       else{

        userLoggedIn = true;
         // Will goto profiler page to get the profile from user. if user denies then some code to be fetched.
         Navigator.push(context,
             MaterialPageRoute(builder: (context) => ProfilerOptionPage(currentUser: _loggedInUser,)));
       }
     }
     else{
       _errorText = "User name or password did not match";


       return ;
     }


   }

// End of login async method



  @override
  Widget build(BuildContext context) {


        return Column(
      children: [
        Padding(
            padding: kTextFieldPadding,
            child: Form(
              key: _userKey,
              child: CustomTextField(
                  controller: _userText,
                  hintText: "enter email",
                  passWord: false,
                  icon: Icons.email,

                  validator: (value) {
                    if(eMailValid( value.toString() ))
                      return null;
                    else
                      return validEmailMessage;
                  },

                validate: (){
                    setState(() {
                      _errorText = "";
                    });
                },

              ),
            )
        ),
        Padding(
          padding: kTextFieldPadding,
          child: Form(
            key: _passKey,

            child: CustomTextField(

              validator: (value){
                if(passWordValid(value.toString()))
                  return null;
                else
                  return validPasswordMessage;
              },

              validate: (){
                setState(() {
                  _errorText = "";
                });
              },

              controller: _passWord,
              hintText: 'Enter Password',
              passWord: true,
              hidePassword: _hidePassword,
              icon: Icons.password_sharp,
              showPassword: (){
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              // key: _passKey,

            ),
          ),
        ),
        ErrorText( errorText: _errorText,),
        CommandButton(
          buttonText: 'Login',
          buttonColor: kPresentTheme.accentColor,
          textColor: kPresentTheme.lightWeightColor,
          borderRadius: BorderRadius.circular(25.0),
          onPressed: () {


            setState(() {
              if(_userKey.currentState!.validate()) {
                if(_passKey.currentState!.validate()){

                  // Async function to enable login
                  _login(_userText.text, _passWord.text);


                } // end of outside
              }
            });

          },
        ),
      ],
    );


  }
}




class Resetter extends StatefulWidget  with InputValidationMixin{

  @override
  _ResetterState createState() => _ResetterState();
}

class _ResetterState extends State<Resetter>  with InputValidationMixin{

  var _emailKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: kTextFieldPadding,
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
          padding: kTextFieldPadding,
          child: CommandButton(
            textColor: Colors.white,
            buttonColor: kPresentTheme.accentColor,
            borderRadius: BorderRadius.circular(20),
            buttonText: 'Reset Password',
            onPressed: () {

              if(_emailKey.currentState!.validate()){
                // TODO code to send user password reset link //
              }



            },
          ),
        ),

      ],
    );
  }
}






