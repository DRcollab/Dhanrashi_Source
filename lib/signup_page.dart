

import 'package:dhanrashi_mvp/data/database.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/data/user_handler.dart';
import 'package:dhanrashi_mvp/data/validators.dart';
import 'package:dhanrashi_mvp/login_page.dart';
import 'package:dhanrashi_mvp/profiler_option_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'constants.dart';
import 'dashboard_old.dart';
import 'package:flutter/material.dart';
import 'components/custom_text_field.dart';

import 'components/custom_text.dart';
import 'profiler.dart';
import 'data/user_data_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/utilities.dart';


const TEXTFIELD_PADDING = const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0);



  class SignUpPage extends StatefulWidget with InputValidationMixin {

  //const Logging({Key? key}) : super(key: key);

    DRUserAccess? currentUser;

    SignUpPage({required this.currentUser});

  @override
  _SignUpState createState() => _SignUpState();
  }

  class _SignUpState extends State<SignUpPage> with InputValidationMixin{

  final _userEmail = TextEditingController();
  final  _userPassword = TextEditingController();
  final _userPassword2 = TextEditingController();
  var _errorText="";

  var _emailKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormState>();
  var _passKey2 = GlobalKey<FormState>();

  var _user = UserHandeler(userTable, userProfileTable);

  late FirebaseAuth fireAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future: Firebase.initializeApp().whenComplete(() => fireAuth = FirebaseAuth.instance);
  }

  void _createUser(String id, String pwd) async {

       // DRUserAccess(fireAuth).createUser(id, pwd);

    try{

      var currentUser = await fireAuth.createUserWithEmailAndPassword(email: id, password: pwd) ;
      if(currentUser.user !=null){

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfilerOptionPage(currentUser: currentUser.user,)));

      }

    }catch(e){

      Utility.showErrorMessage(context, e.toString());
    }



  }




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
              titleText: "Sign Up Page",
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 18),
                  child: Form(
                    key: _emailKey,
                    child: CustomTextField(

                      controller: _userEmail,

                      validate: (){
                        setState(() {
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
                      hintText: 'Enter email to register',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 18),
                  child: Form(
                    key: _passKey,
                    child: CustomTextField(

                      controller: _userPassword,

                      validate: (){
                        setState(() {
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

                      hintText: 'Enter Password ',
                      passWord: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 18),
                  child: Form(
                    key: _passKey2,
                    child: CustomTextField(

                      controller: _userPassword2,

                      validate: (){
                        setState(() {
                          _errorText = "";
                        });
                      },


                      validator: (value){
                        if(_userPassword.text == _userPassword2.text){
                          return null;

                        }
                        else
                          return 'password and confirm password must be same';
                      },
                      icon: Icons.password_sharp,
                      hintText: 'Re-Enter Password',
                      passWord: true,
                    ),
                  ),
                ),
                ErrorText(errorText: _errorText,), //from custom_text
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CommandButton(
                    textColor: kPresentTheme.lightWeightColor,
                    buttonColor: kPresentTheme.accentColor,
                    buttonText: 'Sign Up',
                    borderRadius: BorderRadius.circular(25.0),
                    onPressed: () {


                      setState(() {

                        if(_emailKey.currentState!.validate()){
                         if(_passKey.currentState!.validate()){
                           if(_passKey2.currentState!.validate()){

                                _createUser(_userEmail.text, _userPassword.text);
                               // userLoggedIn = true;

                                 // Navigator.push(context,
                                 //     MaterialPageRoute(builder: (context) => ProfilerPage(currentUser: widget.currentUser,)));


                           }

                         }

                        }
                        else
                          print("false");
                        //_errorText = ""
                     //
                        //   _passKey.currentState.validate();
                     //   _passKey2.currentState.validate();
                      });




                    },
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Already have a login id ?",
                  style: kNormal2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommandButton(
                  buttonText: "Click Here to Login",
                  buttonColor: kPresentTheme.alternateColor,
                  textColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
