import 'package:dhanrashi_mvp/components/banner_class.dart';
import 'package:flutter/material.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/constants.dart';

class InvestmentTabView extends StatelessWidget {
   InvestmentTabView({Key? key}) : super(key: key);


  final   pieData = [

    Task('Investment', 10, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),


  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 200,
            width: 200,
            child: DonutChart(pieData: pieData
            )
        ),

        Container(
          height: 400,
          child: ListView(
            children: [
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
        )
      ],
    );
  }
}
