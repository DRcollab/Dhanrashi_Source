// import 'dart:core';
//
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// //import 'stacked.dart';
// import 'calculation.dart';
// // import 'stacked_horizontal.dart';
//
// class DynamicGraphPage extends StatefulWidget {
//   //DynamicGraphPage({@required this.resultSet});
//
//   //final List resultSet;
//
//   @override
//   _DynamicGraphPageState createState() => _DynamicGraphPageState();
// }
//
// class _DynamicGraphPageState extends State<DynamicGraphPage> {
//   // List<YearWiseAmount> _cashAmount;
//   // List<YearWiseAmount> _equityAmount;
//   // List<YearWiseAmount> _pfAmount;
//   // List<YearWiseAmount> _allInvestmentAmount;
//
//  // List<charts.Series<YearWiseAmount, String>> _chartData;
//
//   void _makeData() {
//     //Calculator newCalc = Calculator();
//     //List allInvestmentAnnualAmt = newCalc.getInvestmentDetail();
//   //  List allInvestmentAnnualAmt = widget.resultSet;
//
//    // print('Make Data: $allInvestmentAnnualAmt');
//     //print('Make Data: $allInvestmentAnnualAmt1');
//
//     int noStack = 3; //Number of goals - 1; hardcoded for now
//     int noOfYear = 18; // hardcoded for now
//
//    // _chartData = List.empty(growable: true);
//
//     // for (int i = 0; i < noStack; i++) {
//     //   _allInvestmentAmount = List.empty(growable: true);
//     //   _cashAmount = List.empty(growable: true);
//     //   _equityAmount = List.empty(growable: true);
//     //   _pfAmount = List.empty(growable: true);
//     //
//     //   for (int j = 1; j <= noOfYear; j++) {
//     //     _allInvestmentAmount.add(YearWiseAmount(
//     //         j.toString(), double.parse(allInvestmentAnnualAmt[i][j])));
//     //
//     //     _cashAmount.add(YearWiseAmount(j.toString(),
//     //         double.parse(allInvestmentAnnualAmt[0][j]))); //i hardcoded
//     //     _equityAmount.add(YearWiseAmount(j.toString(),
//     //         double.parse(allInvestmentAnnualAmt[1][j]))); //i Hardcoded
//     //     _pfAmount.add(YearWiseAmount(j.toString(),
//     //         double.parse(allInvestmentAnnualAmt[2][j]))); //i Hardcoded
//     //     print(allInvestmentAnnualAmt[i][j]);
//     //   }
//     //   //_chartData.add(_cashAmount);
//     //   print('Here');
//     //   print(_allInvestmentAmount);
//     //   print(_cashAmount.toString());
//     //   print(_pfAmount.toString());
//     //   //Color barColor = charts.MaterialPalette.deepOrange.shadeDefault;
//     //
//     //   // _chartData.add(
//     //   //   new charts.Series(
//     //   //     id: allInvestmentAnnualAmt[i][0].toString(),
//     //   //     data: _allInvestmentAmount,
//     //   //     domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
//     //   //     measureFn: (YearWiseAmount yearWiseAmount, _) =>
//     //   //         yearWiseAmount.amount,
//     //   //     displayName: 'Cash',
//     //   //     colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
//     //   //     //colorFn: (_, __) => barColor,
//     //   //   ),
//     //   // );
//     //   print(_chartData.toString());
//     // }
//     // _chartData = List.empty(growable: true);
//     //
//     // _chartData.add(
//     //   new charts.Series(
//     //     id: 'Cash',
//     //     data: _cashAmount,
//     //     domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
//     //     measureFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.amount,
//     //     displayName: 'Cash',
//     //     colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
//     //   ),
//     // );
//     // _chartData.add(
//     //   new charts.Series(
//     //     id: 'Equity',
//     //     data: _equityAmount,
//     //     domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
//     //     measureFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.amount,
//     //     displayName: 'Equity',
//     //     colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
//     //   ),
//     // );
//     // _chartData.add(
//     //   new charts.Series(
//     //     id: 'PF',
//     //     data: _pfAmount,
//     //     domainFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.year,
//     //     measureFn: (YearWiseAmount yearWiseAmount, _) => yearWiseAmount.amount,
//     //     displayName: 'PF',
//     //     colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//     //   ),
//     // );
//     // print(_chartData.toString());
//   }
//
//   @override
//   void initstate() {
//     _makeData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //print('DynamicGraph_Page: ${widget.resultSet}');
//     _makeData();
//
//     return MaterialApp(
//         title: 'Dynamic Page',
//         showPerformanceOverlay: false,
//         theme: ThemeData(
//           // primaryColor: const Color(0xff262545),
//           // primaryColorDark: const Color(0xff201f39),
//           // brightness: Brightness.dark,
//           primarySwatch: Colors.lime,
//         ),
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('Investments'),
//           ),
//
//           //body: DonutAutoLabelChart.withSampleData(),
//           //body: GaugeChart.withSampleData(),
//           //body: TimeSeriesBar.withSampleData(),
//           //body: SimpleSeriesLegend.withSampleData(),
//           body: Center(
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   //height: 500,
//                   children: [
//                     Expanded(
//                         child:
//                         //StackedHorizontalBarChart.withSampleData(resultSet),
//                         //StackedBarChart.withRandomData(),
//                 //         new charts.BarChart(
//                 //        //   _chartData,
//                 //           animate: true,
//                 //           barGroupingType: charts.BarGroupingType.stacked,
//                 //           vertical: true,
//                 //         )),
//                 //   ],
//   //               // ),
//   //             ),
//   //           ),
//   //         ),
//   //       ));
//   // }
// }
//
// class YearWiseAmount {
//   //final String type;
//   final String year;
//   final double amount;
//
//   YearWiseAmount(this.year, this.amount);
// }