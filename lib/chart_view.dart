import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChartView extends StatelessWidget {

  late Widget chartChild;
  ChartView(
      {
    required this.chartChild,
        }
      );




  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child:Container(
          child:this.chartChild,

        )
    );
  }
}
