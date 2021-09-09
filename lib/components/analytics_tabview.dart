import 'package:flutter/material.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';

class AnalyticsTabView extends StatelessWidget {
 // AnalyticsTabView({Key? key}) : super(key: key);



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
    return Column(
      children: [
        Stack(
         // mainAxisAlignment: MainAxisAlignment.center,
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
          ],

        ),
      ],
    );
  }
}
