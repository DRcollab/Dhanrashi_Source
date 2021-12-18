
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:sizer/sizer.dart';

class AnalyticsTabView extends StatelessWidget {
 // AnalyticsTabView({Key? key}) : super(key: key);
  late List<InvestDB> investmentDBs;
  List<Investment> investments = [];
  List<Goal> goals = [];
  late var currentUser;
  late List<GoalDB>  goalDBs;
  List dataSet = List.empty(growable: true);
  // int longestGoalDuration;
  // int longestInvestmentDuration;
  List<GlobalKey?>? showCaseKey;

//{required this.currentUser, required this.investmentDBs, required this.goalDBs}
  AnalyticsTabView({
    required this.currentUser,
    required this.investmentDBs,
    required this.goalDBs,
    // required this.longestInvestmentDuration,
    // required this.longestGoalDuration,
    this.showCaseKey,
  });





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



  if(investments.isNotEmpty && goals.isNotEmpty) {


    fetched = true;
    dataSet = Calculator().getInvVsGoalDetail(
        investments, goals, Global.longestInvestmentDuration,Global.longestGoalDuration);
  }else{
    fetched = false;
  }

    return Column(
      children: [
        fetched?
        Showcase(
            key:showCaseKey![1],
            description: 'See your goal and investment relation',
            child: DynamicGraph(resultSet: dataSet,chartType: ChartType.gauge,))

            :Text('Loading.......', style: DefaultValues.kH1(context),),


        Padding(
          padding:  EdgeInsets.only(
              top:1.0 * DefaultValues.adaptByValue(context, 0.6),
          ),
          child: Container(
            width: 100.w,
            height: 41.h,
            child: fetched ? Showcase(
                key: showCaseKey![2],
                description: 'See how your investment and goals are doing as time goes',
                child: DynamicGraph(resultSet: dataSet,chartType: ChartType.line,)) :Image.asset(kPresentTheme.progressIndicator, scale: 3),
          ),
        ),
      ],
    );
  }
}
