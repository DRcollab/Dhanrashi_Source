import 'package:dhanrashi_mvp/components/recom_class.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:showcaseview/showcaseview.dart';
import '../screens/chart_viewer.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:sizer/sizer.dart';

class AnalyticsTabView extends StatefulWidget {
  // AnalyticsTabView({Key? key}) : super(key: key);
  late List<InvestDB> investmentDBs;
  late var currentUser;
  late List<GoalDB> goalDBs;
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
  State<AnalyticsTabView> createState() => _AnalyticsTabViewState();
}

class _AnalyticsTabViewState extends State<AnalyticsTabView> {
  List<Investment> investments = [];

  List recommList = List.empty(growable: true);

  List<Goal> goals = [];

  List<int> goalPoints = [];

  List dataSet = List.empty(growable: true);
  late final ScrollController _scrollController;

  bool _scrollingUp = false;
  bool _showSummary = true;

  String logoAnime = '${DefaultValues.imageDirectory}/gifs/logo_animation.gif';

  _fetchRecommendations() {
    // int eachGoalYear;

    List temp1 = List.empty(growable: true);
    List temp2 = List.empty(growable: true);
    List temp3 = List.empty(growable: true);
    List temp4 = List.empty(growable: true);

    temp1.add('Year');
    temp2.add('Investments');
    temp3.add('Goals');
    temp4.add('Better/(Worse)');

    if (this.goalPoints.isNotEmpty) {
      this.goalPoints.forEach((element) {
        String eachInvTotal = this.dataSet[0][element];
        String eachGoalTotal = this.dataSet[1][element];
        String year = this.dataSet[2][element].toString();
        double diff = double.parse(eachInvTotal) - double.parse(eachGoalTotal);
        temp1.add(year);
        temp2.add(eachInvTotal);
        temp3.add(eachGoalTotal);
        temp4.add(diff.toString());
        //eachGoalYear = element;
        // eachGoalName = element;
        //  if(goalPoints.contains(eachGoalYear)){
        //    String eachInvTotal = this.dataSet[0][eachGoalYear];
        //    String eachGoalTotal =  this.dataSet[1][eachGoalYear];
        //    double diff = double.parse(eachInvTotal)- double.parse(eachGoalTotal);
        //  }

        //  recommList.add([eachInvTotal, eachGoalTotal,diff.toString()]);

        // if (double.parse(eachInvTotal) > double.parse(eachGoalTotal)) {
        //  // recomMessage = 'You are ahead of your goals at $eachGoalYear years';
        //
        // } else {
        //
        //  // recomMessage =   'You are behind your goals at $eachGoalYear years and need to invest more';
        // }
      });

      recommList.add(temp1);
      recommList.add(temp2);
      recommList.add(temp3);
      recommList.add(temp4);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          if (_scrollController.position.pixels < 200) {
            _scrollingUp = false;
          } else {
            _scrollingUp = true;
          }

          _showSummary = false;
        });
      } else if (_scrollController.position.pixels == 0) {
        setState(() {
          _scrollingUp = false;
          _showSummary = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    investments = List.empty(growable: true);
    goals = List.empty(growable: true);
    bool fetched = false;

    if (widget.investmentDBs.isNotEmpty) {
      widget.investmentDBs.forEach((element) {
        investments.add(element.investment);
      });
      fetched = true;
    } else {
      fetched = false;
    }

    if (widget.goalDBs.isNotEmpty) {
      widget.goalDBs.forEach((element) {
        goals.add(element.goal);
      });
      fetched = true;
    } else {
      fetched = false;
    }

    if (goals.isNotEmpty) {
      goals.forEach((element) {
        if (!goalPoints.contains(element.duration))
          goalPoints.add(element.duration);
      });
    }

    goalPoints.sort();

    if (investments.isNotEmpty && goals.isNotEmpty) {
      fetched = true;
      dataSet = Calculator().getInvVsGoalDetail(investments, goals,
          Global.longestInvestmentDuration, Global.longestGoalDuration);

      _fetchRecommendations();
    } else {
      fetched = false;
    }

    return ListView(
      controller: _scrollController,
      children: [
        fetched
            ? Showcase(
                key: widget.showCaseKey![1]!,
                description: 'See your goal and investment relation',
                child: Container(
                    height: 35.h,
                    child: DynamicGraph(
                      resultSet: dataSet,
                      chartType: ChartType.gauge,
                    )))
            : Center(
                child: Text(
                'Loading.......',
                style: DefaultValues.kH1(context),
              )),
        Padding(
          padding: EdgeInsets.only(
            top: 1.0 * DefaultValues.adaptByValue(context, 0.6),
          ),
          child: Container(
            width: 100.w,
            height:  DefaultValues.screenHeight(context) > 600 ?DefaultValues.screenHeight(context) * 0.38: 35.h,
            child: fetched
                ? Showcase(
                    key: widget.showCaseKey![2]!,
                    description:
                        'See how your investment and goals are doing as time goes',
                    child: Stack(
                      children: [
                        DynamicGraph(
                          resultSet: dataSet,
                          chartType: ChartType.line,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChartViewer(
                                          currentUser: this.widget.currentUser,
                                          isVertical: true,
                                          dataSet: dataSet,
                                          dataSetForTable: recommList,
                                          type: ChartType.line,
                                          useFirstColumnFromList: true,
                                        )));
                          },
                          child: Container(
                            color: Color(0x00000000),
                            width: 100.w,
                            height: DefaultValues.screenHeight(context) > 600 ? 38.h : 35.h,
                          ),
                        )
                      ],
                    ))
                : Image.asset(
                //logoAnime,
               kPresentTheme.progressIndicator,
                scale: 3),
          ),
        ),
        fetched
            ? Tooltip(
                message: 'Hi',
                child:Showcase(
                  key: widget.showCaseKey![3]!,
                  description: 'Drag upward of click on the ^ View the summary of your goals and investments',
                  child: RecomCard(
                    dataSet: recommList,
                    goals: goals,
                    showHeader: this._showSummary,
                    scrolledUp: this._scrollingUp,
                    scrollControl: () {
                      if (this._scrollingUp) {
                        this._scrollController.animateTo(0.0,
                            duration: Duration(milliseconds: 50),
                            curve: Curves.bounceOut);
                        setState(() {
                          this._scrollingUp = false;
                          this._showSummary = true;
                        });
                      } else {
                        this._scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 50),
                            curve: Curves.bounceOut);
                        setState(() {
                          this._scrollingUp = true;
                          this._showSummary = false;
                        });
                      }
                    },
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
