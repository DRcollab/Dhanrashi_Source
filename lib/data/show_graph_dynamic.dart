import 'dart:core';
import 'dart:ffi';
import 'dart:math';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'Archive/stacked.dart';

import 'package:matrix2d/matrix2d.dart';
import 'package:sizer/sizer.dart';

enum ChartType { bar, line, pie , gauge}
enum calculationType { Investment, Goal, InvVsGoal }

class DynamicGraph extends StatefulWidget {

  DynamicGraph({
    required this.resultSet,
    required this.chartType,
    this.isVertical = true,
    this.gallopYears = 1,
  });

  final List resultSet;
  final ChartType chartType;
  final bool isVertical;
  final int gallopYears;

  @override
  _DynamicGraphState createState() => _DynamicGraphState();
}

class _DynamicGraphState extends State<DynamicGraph> {
  late List<YearWiseAmount> _allInvestmentAmount;

  late List<charts.Series<YearWiseAmount, String>> _barChartData;
  late List<charts.Series<YearWiseAmount, int>> _lineChartData;
  late List<charts.Series<Task, String>> _pieChartData;
  late List<charts.Series<Task, String>> _pieChartDataGoal;
  late double goal_ratio = 0;
  late double inv_ratio = 0;

  //late List<charts.Series<YearWiseAmount, int>> _chartData;

  void _makeDataforBar() {
    List allInvestmentAnnualAmt = widget.resultSet;

    // print('Make Data: $allInvestmentAnnualAmt');

    int noStack = allInvestmentAnnualAmt.shape[0] -  2; //Number of goals - 1; hardcoded for now
    int noOfYear = allInvestmentAnnualAmt.shape[1] - 1; // hardcoded for now

    _barChartData = List.empty(growable: true);

    for (int i = 0; i < noStack; i++) {
      _allInvestmentAmount = List.empty(growable: true);

      for (int j = 1; j <= noOfYear; j++) {
        if(j% widget.gallopYears==0) {
          _allInvestmentAmount
              .add(
              YearWiseAmount(j, double.parse(allInvestmentAnnualAmt[i][j]),DefaultValues.graphColors[i%15]));
        }
      }

      // var barColor = charts.MaterialPalette.teal.shadeDefault;
      var barColor = charts.MaterialPalette.deepOrange.shadeDefault;

      _barChartData.add(
        new charts.Series(
          id: allInvestmentAnnualAmt[i][0].toString(),
          data: _allInvestmentAmount,
          domainFn: (YearWiseAmount yearWiseAmount, _) =>
              yearWiseAmount.year.toString(),
          measureFn: (YearWiseAmount yearWiseAmount, _) =>
              yearWiseAmount.amount,
          displayName: allInvestmentAnnualAmt[i][0].toString(),
          colorFn: (YearWiseAmount yearWiseAmount, __) => charts.ColorUtil.fromDartColor(yearWiseAmount.color!),

          //colorFn: (_, __) => barColor,
        ),
      );
      //print(_chartData.toString());
    }
  }

  void _makeDataforLine() {
    List allInvestmentAnnualAmt = widget.resultSet;

    // print('Make Data for Line: $allInvestmentAnnualAmt');
    // print(allInvestmentAnnualAmt.shape);

    int noStack = allInvestmentAnnualAmt.shape[0] -
        1; //Number of goals - 1; hardcoded for now
    int noOfYear = allInvestmentAnnualAmt.shape[1] - 1; // hardcoded for now

    _lineChartData = List.empty(growable: true);

    for (int i = 0; i < noStack; i++) {
      _allInvestmentAmount = List.empty(growable: true);

      for (int j = 1; j <= noOfYear; j++) {
        _allInvestmentAmount
            .add(YearWiseAmount(j, double.parse(allInvestmentAnnualAmt[i][j]),DefaultValues.graphColors[i%15]));
      }
   //   print('allInvestmenamt: $_allInvestmentAmount');

      // var barColor = charts.MaterialPalette.teal.shadeDefault;
     // var barColor = charts.MaterialPalette.deepOrange.shadeDefault;

      _lineChartData.add(
        new charts.Series(
          id: allInvestmentAnnualAmt[i][0].toString(),
          data: _allInvestmentAmount,
          domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
          measureFn: (YearWiseAmount yearWiseAmount, _) =>
              yearWiseAmount.amount,
          displayName: allInvestmentAnnualAmt[i][0].toString(),
          colorFn: (YearWiseAmount yearWiseAmount, __) => charts.ColorUtil.fromDartColor(yearWiseAmount.color!),

          //colorFn: (_, __) => barColor,
        //  labelAccessorFn: (YearWiseAmount row,_) =>'${row.amount}',
        ),
      );
    //  print(_lineChartData.toString());
      print('I am here');
    }
  }

  void _makeDataForGauge(){
   List allInvestmentAnnualAmt = widget.resultSet;
   int noOfYear = allInvestmentAnnualAmt.shape[1] - 1;

   double invValueatlastYear = double.parse( allInvestmentAnnualAmt[0][noOfYear]);
   double goalValueatlastYear = double.parse( allInvestmentAnnualAmt[1][noOfYear]);

    inv_ratio = 7/5;
    goal_ratio = (goalValueatlastYear/invValueatlastYear)*inv_ratio;

 // print('invValueatlastYear: $invValueatlastYear');

    List<Task>   pieData = [

      Task('Investment', invValueatlastYear, kPresentTheme.accentColor),
      Task('Interest Earned', goalValueatlastYear ,kPresentTheme.alternateColor),
    ];



    //var goalValueatlastYear = allInvestmentAnnualAmt[1][noOfYear];

   // print('--------=============');
   // print(invValueatlastYear);

    _pieChartData = List.empty(growable: true);
    _pieChartData.add(
      new charts.Series(
        id: 'inv',
        data: [pieData[0]],
        domainFn: (Task yearWiseAmount, _) => yearWiseAmount.task,
        measureFn: (Task yearWiseAmount, _) =>
        yearWiseAmount.value,
        displayName:'title', //allInvestmentAnnualAmt[0][0].toString(),
        colorFn: (Task yearWiseAmount, __) => charts.ColorUtil.fromDartColor(yearWiseAmount.color),


      ),
    );
   _pieChartDataGoal = List.empty(growable: true);
   _pieChartDataGoal.add(
     new charts.Series(
       id: 'inv',
       data: [pieData[1]],
       domainFn: (Task yearWiseAmount, _) => yearWiseAmount.task,
       measureFn: (Task yearWiseAmount, _) =>
       yearWiseAmount.value,
       displayName:'title', //allInvestmentAnnualAmt[0][0].toString(),
       colorFn: (Task yearWiseAmount, __) => charts.ColorUtil.fromDartColor(yearWiseAmount.color),


     ),
   );



  }

  Widget getWidget() {
   // print('get Widget');

    if (widget.chartType == ChartType.bar) {
      return new charts.BarChart(_barChartData,

          animate: true,
          //defaultRenderer: new charts.BarRendererConfig(
          //     // By default, bar renderer will draw rounded bars with a constant
          //     // radius of 100.
          //     // To not have any rounded corners, use [NoCornerStrategy]
          //     // To change the radius of the bars, use [ConstCornerStrategy]
          //     cornerStrategy: const charts.ConstCornerStrategy(30)),
          barGroupingType: charts.BarGroupingType.stacked,
          vertical: widget.isVertical);
    } else if(widget.chartType == ChartType.line){
      return new charts.LineChart(
        _lineChartData,
        behaviors: [

          charts.ChartTitle('Year', behaviorPosition: charts.BehaviorPosition.bottom,
                titleStyleSpec: charts.TextStyleSpec(fontSize: 12.sp.toInt(),fontWeight: 'b'),

          ),
          charts.ChartTitle('Investments',behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 12.sp.toInt()),



          ),
          charts.ChartTitle('Goals',behaviorPosition: charts.BehaviorPosition.end,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 12.sp.toInt()),
          ),


        ],
          defaultRenderer:
                  charts.LineRendererConfig(
                  includeArea: true,
                  stacked: false,
                    strokeWidthPx: 3,
                    roundEndCaps: true,
                  ),
                  animate: true,


        );

      // return new charts.BarChart(_barChartData,
      //     animate: true,
      //     defaultRenderer: new charts.BarRendererConfig(
      //         // By default, bar renderer will draw rounded bars with a constant
      //         // radius of 100.
      //         // To not have any rounded corners, use [NoCornerStrategy]
      //         // To change the radius of the bars, use [ConstCornerStrategy]
      //         cornerStrategy: const charts.ConstCornerStrategy(30)),
      //     barGroupingType: charts.BarGroupingType.stacked,
      //     vertical: false);
    }
    else{
      // Gauge style charts
      bool viewLabel = false;
      return Stack(
        alignment: Alignment.topCenter,
        children: [

          Container(
            width:28.h,
            height:28.h,
            child: charts.PieChart<String>(
              List.from(_pieChartData),
              animate: true,

              animationDuration: Duration(milliseconds: 200),
              // behaviors: [
              //
              //   charts.DatumLegend(
              //     outsideJustification: charts.OutsideJustification.middleDrawArea,
              //     horizontalFirst: false,
              //     desiredMaxColumns: 2,
              //    // cellPadding: EdgeInsets.only(right: 4.0,bottom: 4.0),
              //    // entryTextStyle:
              //
              //   ),
              //
              // ],
              defaultRenderer: new charts.ArcRendererConfig(
                arcWidth: (20 * DefaultValues.adaptByValue(context, 0.8)).ceil(),
                 startAngle: 1 * pi,
                 arcLength: inv_ratio * pi,
                arcRendererDecorators: viewLabel ? [

                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.auto
                )
                ] : [],



              )
              ,
            ),
          ),
          Padding(
              padding:  EdgeInsets.symmetric(
                vertical: 4.5.h,
                horizontal: 2.w,
              ),
              child: Container(
                width:18.8.h,
                height: 18.8.h,
                 child:charts.PieChart<String>(
                   List.from(_pieChartDataGoal),
                   animate: true,

                   animationDuration: Duration(milliseconds: 200),
                   // behaviors: [
                   //
                   //   charts.DatumLegend(
                   //     outsideJustification: charts.OutsideJustification.middleDrawArea,
                   //     horizontalFirst: false,
                   //     desiredMaxColumns: 2,
                   //    // cellPadding: EdgeInsets.only(right: 4.0,bottom: 4.0),
                   //    // entryTextStyle:
                   //
                   //   ),
                   //
                   // ],
                   defaultRenderer: new charts.ArcRendererConfig(
                     arcWidth: (20 * DefaultValues.adaptByValue(context, 0.8)).ceil(),
                     startAngle: 1 * pi,
                     arcLength: goal_ratio * pi,
                     arcRendererDecorators: viewLabel ? [

                     new charts.ArcLabelDecorator(
                         labelPosition: charts.ArcLabelPosition.auto
                     )
                     ] : [],



                   )
                   ,
                 ),

              )
          ),
          Padding(
            padding: EdgeInsets.only(left:1.w,top:25.h),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,width: 20,
                    color: DefaultValues.graphColors[0],

                  ),
                  Padding(
                    padding: EdgeInsets.only(left:8.0, top:8.0, bottom: 8.0),
                    child: Text('Investments',style: DefaultValues.kH4(context),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:8.0, top:8.0, bottom: 8.0),
                    child: Container(
                      height: 10,width: 20,
                      color: DefaultValues.graphColors[1],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:8.0, top:8.0, bottom: 8.0),
                    child: Text('Goals',style: DefaultValues.kH4(context)),
                  ),
                ],
              ),
            ),
          ),




        ],
      );
    }
  }

  @override
  void initstate() {
    //_makeDataforBar();
  }

  @override
  Widget build(BuildContext context) {
    //print('DynamicGraph_Page: ${widget.resultSet}');

    if (widget.chartType == ChartType.bar) {
      _makeDataforBar();
    } else if (widget.chartType == ChartType.line)
      {
      _makeDataforLine();
    }
    else{
      _makeDataForGauge();
    }
    return getWidget();
  }
}

class YearWiseAmount {
  //final String type;
  final int year;
  final double amount;
  Color? color;
  YearWiseAmount(this.year, this.amount, this.color);
}

class Task{
  String task = '';
  double value = 0.0;
  Color color = Color(0);
  Task(this.task,this.value,this.color);


}