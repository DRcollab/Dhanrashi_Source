import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChartTabView extends StatelessWidget {

  late Widget chartChild;
  var currentUser;
  ChartTabView(
      {
        required this.chartChild,
       required  this.currentUser,
        }
      );



  @override
  Widget build(BuildContext context) {
    return Container(
      child:this.chartChild,

    );
  }
}
