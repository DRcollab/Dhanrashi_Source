


import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
class RecomCard extends StatefulWidget {


  late List dataSet;
  late List goals;



  @override
  State<RecomCard> createState() => _RecomCardState();

  RecomCard({required this.dataSet, required this.goals});
}

class _RecomCardState extends State<RecomCard> {
  //var dataSet;

 // var goals ;

   String recomMessage = '';
   String negativeMessage = 'You are behind your goals at';
   String positiveMessage = 'You are ahead of your goals at';



  _fetchRecommendations(){

    // int eachGoalYear;
    // String eachGoalName;

    print(widget.dataSet[0]);
    print(widget.dataSet[1]);
    print(widget.dataSet[2]);
    print(widget.dataSet[3]);


    if(widget.dataSet.isNotEmpty){

      for (int i =1 ; i<widget.dataSet.length ; i++){
        if(double.parse(widget.dataSet[3][i])>0){
          positiveMessage   = positiveMessage + ' '+ widget.dataSet[0][i] + ',';
        }else{
          negativeMessage   = negativeMessage + ' ' + widget.dataSet[0][i] + ',';
        }
      }


      // widget.dataSet[3].forEach((element) {
      //  // print(element[4]);
      //    if( double.parse(element) > 0){
      //
      //   }else{
      //     negativeMessage =  negativeMessage + element[1];
      //   }
      // });
    }

    recomMessage = Utility.formatMessage(negativeMessage) + ' years';

  //
  //   if (widget.goals.isNotEmpty) {
  //     widget.goals.forEach((element) {
  //       eachGoalYear = element.duration;
  //       eachGoalName = element.name;
  //       String eachInvTotal = widget.dataSet[0][eachGoalYear];
  //       String eachGoalTotal = widget.dataSet[1][eachGoalYear];
  //
  //
  //       if (double.parse(eachInvTotal) > double.parse(eachGoalTotal)) {
  //         recomMessage = 'You are ahead of your goals at $eachGoalYear years';
  //
  //       } else {
  //
  //          recomMessage =   'You are behind your goals at $eachGoalYear years and need to invest more';
  //       }
  //     });
  //   }
   }

  @override
  Widget build(BuildContext context) {


    _fetchRecommendations();


    return ReportCard(

        borderRadius: BorderRadius.circular(20),
        baseColor: kPresentTheme.themeColor,
        titleText: '',
        requiredTitleBar: false,
        children: [

          Tooltip(
            message: 'Hi',
              child: ListTile(
                tileColor: kPresentTheme.alternateColor,
                leading: Icon(Icons.info, size: 28,),
                  title: Text(recomMessage, style: DefaultValues.kNormal3(context),))),

        ],

    );
  }
}
