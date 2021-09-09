

import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:flutter/material.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'components/constants.dart';
import 'dashboard.dart';
import 'profiler.dart';
import 'models/user_data_class.dart';

class ProfilerOptionPage extends StatelessWidget {
  //const ProfilerOptionPage({Key? key}) : super(key: key);

  final  currentUser;
  final String currentUserName = "";


  ProfilerOptionPage({required this.currentUser}){

   // currentUserName = currentUser.whenComplete(() => null)
   // print(currentUser.user!.email);
  }



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentUser: this.currentUser,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Padding(
            padding: const EdgeInsets.only(top:8,left: 18,right: 18, bottom: 8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(


                  ),
                  child: Image.asset('images/info.png',
                    height: 200,
                    width: 200,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 8, right: 8,bottom: 8),
                  child: Text("Hey ! ${currentUser!.email}  \nThanks for choosing us",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: kPresentTheme.accentColor,
                  )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Looks like we dont know much of you.",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kPresentTheme.accentColor,
                      )
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 28),
            child: Text("Knowing you more, will help us to help you more. How about getting some information about you ?",
              style: TextStyle(
                fontSize: 20.0,
                color: kPresentTheme.accentColor,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommandButton(
                      textSize: 18,
                      textColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      buttonColor: kPresentTheme.alternateColor,
                      buttonText: "OK",
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => ProfilerPage(currentUser: this.currentUser,),
                        )
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommandButton(
                      textSize: 18,
                      buttonColor: kPresentTheme.accentColor,
                      textColor: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        buttonText: "No, I am not sharing",
                        onPressed: (){
                          // TODO code to got to loading page
                        }, ),
                  )
                ]

              ),
            ),
          ),

          Center(child: Text("Worried about safety of your information?",
          style: DefaultValues.kAdviceTextStyleDark(context),)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinkText(
                  linkText: "Click here to know our Privacy Policy",
                  type: LinkTextType.DARK,
                  onPressed: (){}),
            ),
          ),

        ],
      ),

    );
  }
}
