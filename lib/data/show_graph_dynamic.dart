import 'dart:core';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'Archive/stacked.dart';
import 'constant.dart';
import 'package:matrix2d/matrix2d.dart';

enum ChartType { bar, line, pie }
enum calculationType { Investment, Goal, InvVsGoal }

class DynamicGraph extends StatefulWidget {
  DynamicGraph({required this.resultSet, required this.chartType});

  final List resultSet;
  final ChartType chartType;

  @override
  _DynamicGraphState createState() => _DynamicGraphState();
}

class _DynamicGraphState extends State<DynamicGraph> {
  late List<YearWiseAmount> _allInvestmentAmount;

  late List<charts.Series<YearWiseAmount, String>> _barChartData;
  late List<charts.Series<YearWiseAmount, int>> _lineChartData;
  //late List<charts.Series<YearWiseAmount, int>> _chartData;

  void _makeDataforBar() {
    List allInvestmentAnnualAmt = widget.resultSet;

    print('Make Data: $allInvestmentAnnualAmt');

    int noStack = allInvestmentAnnualAmt.shape[0] -  2; //Number of goals - 1; hardcoded for now
    int noOfYear = allInvestmentAnnualAmt.shape[1] - 1; // hardcoded for now

    _barChartData = List.empty(growable: true);

    for (int i = 0; i < noStack; i++) {
      _allInvestmentAmount = List.empty(growable: true);

      for (int j = 1; j <= noOfYear; j++) {
        _allInvestmentAmount
            .add(YearWiseAmount(j, double.parse(allInvestmentAnnualAmt[i][j])));
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
          //colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,

          //colorFn: (_, __) => barColor,
        ),
      );
      //print(_chartData.toString());
    }
  }

  void _makeDataforLine() {
    List allInvestmentAnnualAmt = widget.resultSet;

    print('Make Data for Line: $allInvestmentAnnualAmt');
    print(allInvestmentAnnualAmt.shape);

    int noStack = allInvestmentAnnualAmt.shape[0] -
        1; //Number of goals - 1; hardcoded for now
    int noOfYear = allInvestmentAnnualAmt.shape[1] - 1; // hardcoded for now

    _lineChartData = List.empty(growable: true);

    for (int i = 0; i < noStack; i++) {
      _allInvestmentAmount = List.empty(growable: true);

      for (int j = 1; j <= noOfYear; j++) {
        _allInvestmentAmount
            .add(YearWiseAmount(j, double.parse(allInvestmentAnnualAmt[i][j])));
      }
      print('allInvestmenamt: $_allInvestmentAmount');

      // var barColor = charts.MaterialPalette.teal.shadeDefault;
      var barColor = charts.MaterialPalette.deepOrange.shadeDefault;

      _lineChartData.add(
        new charts.Series(
          id: allInvestmentAnnualAmt[i][0].toString(),
          data: _allInvestmentAmount,
          domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
          measureFn: (YearWiseAmount yearWiseAmount, _) =>
              yearWiseAmount.amount,
          displayName: allInvestmentAnnualAmt[i][0].toString(),
          //colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,

          //colorFn: (_, __) => barColor,
        ),
      );
      print(_lineChartData.toString());
      print('I am here');
    }
  }

  Widget getWidget() {
    print('get Widget');
    if (widget.chartType == ChartType.bar) {
      return new charts.BarChart(_barChartData,
          animate: true,
          // defaultRenderer: new charts.BarRendererConfig(
          //     // By default, bar renderer will draw rounded bars with a constant
          //     // radius of 100.
          //     // To not have any rounded corners, use [NoCornerStrategy]
          //     // To change the radius of the bars, use [ConstCornerStrategy]
          //     cornerStrategy: const charts.ConstCornerStrategy(30)),
          barGroupingType: charts.BarGroupingType.stacked,
          vertical: true);
    } else {
      return new charts.LineChart(_lineChartData,
          defaultRenderer:
              new charts.LineRendererConfig(
                  includeArea: true,
                  stacked: true),
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
    } else {
      _makeDataforLine();
    }

    return getWidget();
  }
}

class YearWiseAmount {
  //final String type;
  final int year;
  final double amount;

  YearWiseAmount(this.year, this.amount);
}
