

import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'components/dounut_charts.dart';
import 'components/table_view.dart';


class IndividualInvestment extends StatelessWidget {

  var currentUser;
  late List data;
  late List<Task> pieData;
  late List<Task> futurePieData;

  IndividualInvestment({
    required this.currentUser,
    required this.data,
    required this.pieData,
    required this.futurePieData,
});

  @override
  Widget build(BuildContext context) {
   //
   // List pieData = [
   //    Task('Investment', investedAmount, kPresentTheme.accentColor),
   //    Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),
   //  ];

    return CustomScaffold(
      currentUser: this.currentUser,
        child: ListView(
          children: [
            Center(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(data[0][0], style: DefaultValues.kH2(context),),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 22.h,
                  width: 48.w,
                  child: DonutChart(pieData: this.pieData,arcWidth: 18,),),
                Container(
                  height: 22.h,
                  width: 48.w,
                  child: DonutChart(pieData: this.futurePieData,arcWidth: 18,),),
              ],
            ),
            Card(
              child: ListTile(
                title: Text('Invested Amount here : }'),
              ),
            ),
            TableView(
              arrayList: this.data,
            ),
          ],
        )
    );
  }
}
