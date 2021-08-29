import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'banner_class.dart';

class GoalsTabView extends StatelessWidget {
  GoalsTabView({Key? key}) : super(key: key);


  final   pieData = [

    Task('Investment', 21, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),
    Task('Car', 10 ,Colors.black26),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView(
        children: [
          Container(
              height: 200,
              width: 200,
              child: DonutChart(pieData: pieData
              )
          ),

      Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),
          Shingle(),


        ],
      ),
    );
  }
}
