import 'package:flutter/material.dart';

class ChartTabView extends StatelessWidget {
  late Widget chartChild;
  var currentUser;
  ChartTabView({
    required this.chartChild,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.chartChild,
    );
  }
}
