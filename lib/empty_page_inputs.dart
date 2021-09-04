import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/data/user_data_class.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'goal_input.dart';

class EmptyPage extends StatelessWidget {

 var currentUser;

  EmptyPage({required this.currentUser }) ;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        currentUser: this.currentUser,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(child: Image.asset('images/empty.png'),),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Text('It seems that  you have not entered any goal and investments for us to analyse.',
                          style: kNormal1,

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
