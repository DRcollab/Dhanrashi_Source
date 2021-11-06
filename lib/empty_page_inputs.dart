import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'data/global.dart';
import 'goal_input.dart';

//<a href="https://storyset.com/work">Work illustrations by Storyset</a>
//<a href="https://storyset.com/work">Work illustrations by Storyset</a>


class EmptyPage extends StatelessWidget {

 var currentUser;
 String message = '';
 Color messageColor;
 int investmentCount = 0;
 int goalCount = 0;
 String messageIndex = 'empty'; // Used to show message from Utility.message[]
  EmptyPage({
    required this.currentUser,
    this.message = '',
    this.messageColor = Colors.green,
    this.investmentCount = 0,
    this.goalCount = 0,

  }) ;

  @override
  Widget build(BuildContext context) {


     if(Global.investmentCount == 0){
      if(Global.goalCount == 0) {
        messageIndex = 'empty';
      }else{
        messageIndex = 'empty_inv';
      }

    }else{
      messageIndex = 'empty_goal';
    }



    return CustomScaffold(
        currentUser: this.currentUser,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

           this.message !='' ? Container(
             color: messageColor,
             child: ListTile(

               leading: CircleAvatar(
                 backgroundColor: Colors.amber,
                 child: Image.asset('images/check.png',height: 20,width: 20,),

               ) ,
                title:Text(message, style: DefaultValues.kH3(context),),
              ),
           ):SizedBox(),
            Container(child: Image.asset('images/gifs/empty.gif',scale: 0.1,),
                  height: 250,width: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Text( Utility.messages[messageIndex]!,
                          style:DefaultValues.kH2(context),

              ),
            ),
            //CommandButton(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Global.investmentCount == 0 ? CommandButton(
                  onPressed: (){

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InvestmentInputScreen(currentUser: currentUser,)));
                  },

                  buttonColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  textColor: kPresentTheme.lightWeightColor,
                  buttonText: 'Add Investments',


              ): SizedBox(),
            ),

            Padding(
              padding: const EdgeInsets.only(left:18.0, right: 18.0),
              child:Global.goalCount == 0 ? CommandButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GoalsInputScreen(currentUser: currentUser,)));
                  },
                  buttonColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  textColor: kPresentTheme.lightWeightColor,
                  buttonText: 'Add Goals',
              ):SizedBox(),
            )
          ],
        )
    );
  }
}
