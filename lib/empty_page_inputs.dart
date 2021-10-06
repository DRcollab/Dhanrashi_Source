import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'goal_input.dart';

class EmptyPage extends StatelessWidget {

 var currentUser;
 String message = '';
 Color messageColor;
  EmptyPage({required this.currentUser, this.message = '', this.messageColor = Colors.green }) ;

  @override
  Widget build(BuildContext context) {
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
            Container(child: Image.asset('images/empty.png'),),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Text('It seems that  you have not entered any goal and investments for us to analyse.',
                          style:DefaultValues.kNormal1(context),

              ),
            ),
            //CommandButton(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
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
            ),

            Padding(
              padding: const EdgeInsets.only(left:18.0, right: 18.0),
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
            )
          ],
        )
    );
  }
}
