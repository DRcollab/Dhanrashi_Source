import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChartView extends StatelessWidget {

  late Widget chartChild;
  var currentUser;
  ChartView(
      {
        required this.chartChild,
       required  this.currentUser,
        }
      );



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child:Container(
          child:this.chartChild,

        ),
      currentUser: this.currentUser,
    );
  }
}
