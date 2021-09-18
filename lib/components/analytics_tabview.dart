
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:loading_gifs/loading_gifs.dart';

class AnalyticsTabView extends StatelessWidget {
 // AnalyticsTabView({Key? key}) : super(key: key);
  late List<InvestDB> investmentDBs;
  List<Investment> investments = [];
  List<Goal> goals = [];
  late var currentUser;
  late List<GoalDB>  goalDBs;
  List dataSet = List.empty(growable: true);
  int longestGoalDuration;
  int longestInvestmentDuration;

//{required this.currentUser, required this.investmentDBs, required this.goalDBs}
  AnalyticsTabView({
    required this.currentUser,
    required this.investmentDBs,
    required this.goalDBs,
    required this.longestInvestmentDuration,
    required this.longestGoalDuration
  });



  final   pieData = [

    Task('Investment', 10, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),


  ];

  final   pieData1 = [

    Task('Investment', 21, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),
    Task('Car', 10 ,kPresentTheme.alternateColor.withBlue(129)),

  ];

  @override
  Widget build(BuildContext context) {

  investments = List.empty(growable: true);
  goals = List.empty(growable: true);
  bool fetched = false;

  if(investmentDBs.isNotEmpty) {
    investmentDBs.forEach((element) {
      investments.add(element.investment);
    });
    fetched = true;
  }
  else{
    fetched = false;
  }

  if(goalDBs.isNotEmpty) {
    goalDBs.forEach((element) {
      goals.add(element.goal);
    });
    fetched = true;
  }else{

    fetched = false;
  }

  print('fetched = $fetched');
  print('goal db${goalDBs.length}');
  print('goal db${investmentDBs.length}');

  if(investments.isNotEmpty && goals.isNotEmpty) {
    print('longest inv time : $longestInvestmentDuration');
    print('longest goal time : $longestGoalDuration');

    fetched = true;
    dataSet = Calculator().getInvVsGoalDetail(
        investments, goals, longestInvestmentDuration, longestGoalDuration);
  }else{
    fetched = false;
  }

    return Column(
      children: [
        Stack(
         alignment: Alignment.topCenter,
          children: [
            Container(
                width:220, height: 220,
                child: DonutChart(pieData: pieData, viewLabel: false, arcWidth: 30,),
            ),

            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Container(
                  width:150, height: 150,
                  child: DonutChart(pieData: pieData1)),
            ),

            Padding(
              padding: const EdgeInsets.only(top:250.0),
              child: Container(
                width: 450,
                height: 220,
                child: fetched ? DynamicGraph(resultSet: dataSet,chartType: ChartType.line,) :Image.asset(circularProgressIndicator, scale: 5),
              ),
            ),
          ],

        ),
      ],
    );
  }
}
