


import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
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

  _fetchRecommendations(){

    int eachGoalYear;
    String eachGoalName;


    if (widget.goals.isNotEmpty) {
      widget.goals.forEach((element) {
        eachGoalYear = element.duration;
        eachGoalName = element.name;
        String eachInvTotal = widget.dataSet[0][eachGoalYear];
        String eachGoalTotal = widget.dataSet[1][eachGoalYear];


        if (double.parse(eachInvTotal) > double.parse(eachGoalTotal)) {
          recomMessage = 'You are ahead of your goals at $eachGoalYear years';

        } else {

           recomMessage =   'You are behind your goals at $eachGoalYear years and need to invest more';
        }
      });
    }
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
              child: Text(recomMessage, style: DefaultValues.kNormal3(context),)),

        ],

    );
  }
}
