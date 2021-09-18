/// This code is written by Shubhadeep Sarkar
/// Login page consists  two view element 1. Logger and 2. Resetter
///

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

import 'components/on_error_screen.dart';
import 'landing.dart';
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


class Login_Page extends StatefulWidget {

//UserData currentUser = UserData.create();

//DRUserAccess? currentUser;
// determine whether user opted for reset



  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

   bool profileReady = false; // will be used to determine if profiler page to be navigated or to dhanrashi
    DRUserAccess? currentUser; // Store the  Name of the user (not user id) if users decides not fill in name then user id will be used//
  // The currentUser will be displayed on dhanrashi or other places....

  // bool useForReset = false;

   int cardIndex = 0;


  /// Goto Logger class definition to see how login is happening
   ///

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     //currentUser = widget.currentUser;




   }

  @override
  void dispose(){


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
              Text('Dhanrashi', style:DefaultValues.kH1(context),),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0,right:18.0,top:28.0,bottom:18),
          child: InputCard(
          titleText: titleText[cardIndex],
          children: [
             //Logger(),
            cardView[cardIndex],
            Padding(
              padding:DefaultValues.kTextFieldPadding(context),
              child: LinkText(
                  type: LinkTextType.DARK,
                  linkText: linkText[cardIndex],
                  displaySize: 18.0,

                  onPressed: () {
                    setState(() {
                      //useForReset = true;
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
                  style:DefaultValues.kNormal2(context),
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

// Logging provides screen for login screen with two textfield
// 1. login id  or email
// 2. password.






class Logger extends StatefulWidget with InputValidationMixin {

 // DRUserAccess? currentUser;
 // Logger();




  @override
  _LoggerState createState() => _LoggerState();
}

class _LoggerState extends State<Logger> with InputValidationMixin {


   bool _profileReady = false; // will be used to determine if profiler page to be navigated or to dhanrashi
  //final String currentUser = ""; // Store the  Name of the user (not user id) if users decides not fill in name then user id will be used//
  // The currentUser will be displayed on dhanrashi or other places....

   late final _loggedInUser;
  String _errorText = "";
 late final _userText;
 late final _passWord;
  late final  _loginKey;// = GlobalKey<FormState>(); // Used for user email validation
  late final _passwordKey;// = GlobalKey<FormState>(); // Used fot password validation

 var _user = UserHandeler(userTable, userProfileTable);


   bool loginState = false;
  // late DRUserAccess currentUser;

   late FirebaseAuth fireAuth ;
   late FirebaseFirestore fireStore;
   late DRProfileAccess profileAccess;
  bool _hidePassword = true;
 late Profile profile;

  @override
  void dispose(){
  // _userText.dispose();
  // _passWord.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _loginKey = GlobalKey<FormState>();
    _passwordKey = GlobalKey<FormState>();
   _userText = TextEditingController();
    _passWord = TextEditingController();
    profile = Profile.create(); // Custom
    super.initState();

   future: Firebase.initializeApp().whenComplete(() {
     fireAuth = FirebaseAuth.instance;
     fireStore = FirebaseFirestore.instance;
         });

  }



   Future fetchProfile( var currentUser) async {

     // late Profile profile;

     try {
       fireStore.collection('pjdhan_users').where(
           'Uid', isEqualTo: currentUser.uid)
           .get()
           .then((QuerySnapshot snapshot) {
         snapshot.docs.forEach((f) {
           String email = f.get('email');
           String userID = f.get('Uid');
           String docID = fireStore
               .collection('pjdhan_users')
               .doc()
               .id;

           String firstName = f.get('first_name');
           String lastName = f.get('last_name');
           Timestamp dob = f.get('DOB');
           String incomeRange = f.get('income');

           setState(() {
             profile = Profile(
               firstName: firstName,
               lastName: lastName,
               DOB: dob.toDate(),
               incomeRange: incomeRange,
               docId: docID,
             );
           });



         });
       });
       //return profile;
     }catch(e){
       print('This is the error : -> $e');
     }
   }






  // This async method implements login
   void _login(String id, String pwd) async {


     try{
       var _loggedInUser = await  fireAuth.signInWithEmailAndPassword(email: id, password: pwd); // DRUserAccess(fireAuth).authUser(id, pwd);
       if (_loggedInUser.user != null) {

         profileAccess = DRProfileAccess(fireStore, _loggedInUser.user);

       //  profile = await  profileAccess.fetchProfile();
         fetchProfile(_loggedInUser.user);
          Future.delayed(Duration(seconds: 3));
         print(' Profile doc Id : ${profile.docId}');
          if(profile.docId != '') {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    Dashboard(currentUser: _loggedInUser.user,)));
          }
          else{
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    ProfilerOptionPage(currentUser: _loggedInUser.user,)));
          }
       }


     }catch(e){

       Utility.showErrorMessage(context, e.toString());
        print(e);
     }





   }

// End of login async method



  @override
  Widget build(BuildContext context) {


        return Column(
      children: [
        Padding(
            padding:DefaultValues.kTextFieldPadding(context),
            child: Form(
              key: _loginKey,
              child: CustomTextField(
                 controller: _userText,

                  hintText: "enter email",
                  passWord: false,
                  icon: Icons.email,
                //  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if(eMailValid( value.toString() ))
                      return null;
                    else
                      return validEmailMessage;
                  },

                validate: (){
                    setState(() {
                      if(_errorText != ''){
                        _errorText = '';
                      }

                      print('errorText');
                   });
                },

              ),
            )
        ),
        Padding(
          padding:DefaultValues.kTextFieldPadding(context),
          child: Form(
            key: _passwordKey,

            child: CustomTextField(

             // textInputAction: TextInputAction.done,
              validator: (value){
                if(passWordValid(value.toString()))
                  return null;
                else
                  return validPasswordMessage;
              },

              validate: (){
                setState(() {
                  if(_errorText != ''){
                    _errorText = '';
                  }

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

//
            setState(() {
              if(_loginKey.currentState!.validate()) {
                if(_passwordKey.currentState!.validate()){

                  // Async function to enable login
                 _login(_userText.text, _passWord.text);
                  //print('profile from outseide :${profile.docId}');


                } // end of outside
              }
            });

          },
        ),
      ],
    );

// copy here
  }
}




class Resetter extends StatefulWidget  with InputValidationMixin{

  @override
  _ResetterState createState() => _ResetterState();
}

class _ResetterState extends State<Resetter>  with InputValidationMixin{

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

    try{
      await fireAuth.sendPasswordResetEmail(email: emailController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login_Page()),
      );
      // fireAuth.sendPasswordResetEmail(email: emailController.text);
    }catch(e){

      Utility.showErrorMessage(context, e.toString());
      print('error mesage :${e}');

    }

  }



  var emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(

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
            textColor: Colors.white,
            buttonColor: kPresentTheme.accentColor,
            borderRadius: BorderRadius.circular(20),
            buttonText: 'Reset Password',
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
    );
  }
}






