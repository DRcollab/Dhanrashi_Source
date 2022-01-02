import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'components/constants.dart';
import 'dashboard.dart';
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

  GlobalKey _key1 = GlobalKey();
  GlobalKey _key2 = GlobalKey();


  @override
  Widget build(BuildContext context) {


     if(Global.investmentCount == 0){
      if(Global.goalCount == 0) {
        messageIndex = 'empty';
      }else{
        messageIndex = 'empty_inv';
      }

    }else{
       if(Global.goalCount == 0) {
         messageIndex = 'empty_goal';
       }else{
         messageIndex = 'empty';
       }

    }



    return ShowCaseWidget(

      builder: Builder(
        builder: (context) {
          return CustomScaffold(
              helper: (){
                ShowCaseWidget.of(context)!.startShowCase([_key1,_key2]);
              },
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
                    child: Text( DefaultValues.messages[messageIndex]!,
                                style:DefaultValues.kH2(context),

                    ),
                  ),
                  //CommandButton(),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Global.goalCount == 0 ? Showcase(
                      key: _key1,
                      description: 'Click here to add GOALS',
                      shapeBorder: CircleBorder(),
                      overlayPadding: EdgeInsets.all(8),
                      child: CommandButton(
                          onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => GoalsInputScreen(currentUser: currentUser,)));
                          },

                          buttonColor: kPresentTheme.accentColor,
                          borderRadius: BorderRadius.circular(20),
                          textColor: kPresentTheme.lightWeightColor,
                          buttonText: 'Add Goals',


                      ),
                    ): SizedBox(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:18.0, right: 18.0),
                    child:Global.investmentCount == 0 ? Showcase(
                      key: _key2,
                      description: 'Click here to add INVESTMENTS',
                      shapeBorder: CircleBorder(),
                      overlayPadding: EdgeInsets.all(8),
                      child: CommandButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => InvestmentInputScreen(currentUser: currentUser,)));
                          },
                          buttonColor: kPresentTheme.accentColor,
                          borderRadius: BorderRadius.circular(20),
                          textColor: kPresentTheme.lightWeightColor,
                          buttonText: 'Add Investments',
                      ),
                    ):SizedBox(),
                  ),

                  messageIndex == ''? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CommandButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Dashboard(currentUser: currentUser,)));
                        },
                      buttonColor: kPresentTheme.accentColor,
                      borderRadius: BorderRadius.circular(20),
                      textColor: kPresentTheme.lightWeightColor,
                      buttonText: 'Go back to dash board',
                    ),
                  ):SizedBox(),
                ],
              )
          );
        }
      ),
    );
  }
}
