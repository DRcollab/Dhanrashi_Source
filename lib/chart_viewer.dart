import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'components/chart_tab_view.dart';
import 'components/constants.dart';
import 'components/table_view.dart';


class ChartViewer extends StatefulWidget {

  late Widget chartChild;
  var currentUser;
  ChartViewer(
  {
    required this.chartChild,
    this.currentUser,
  }
      );

  @override
  _ChartViewerState createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        child:Padding(
          padding: EdgeInsets.only(top:25),
          child: Material(
            child: TabBar(

             // isScrollable: true,
              indicator: RectangularIndicator(
                //height: 5,
                topLeftRadius: 15,
                topRightRadius: 15,
                bottomLeftRadius: 15,
                bottomRightRadius: 15,
                horizontalPadding: 10,
                verticalPadding: 7,

                //tabPosition: TabPosition,
                paintingStyle: PaintingStyle.fill,
                strokeWidth: 10,
              ),
              indicatorColor: kPresentTheme.accentColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: DefaultValues.kH4(context),
              labelPadding: EdgeInsets.only(top: 0),
              tabs: [
                Tab(text:'Chart',),
                Tab(text:'Table',),
              ],
            ),
          ),
        ),
        foot: TabBarView(
          children: [
            ChartView(
              currentUser: widget.currentUser,
              chartChild: widget.chartChild,
            ),
            TableView(),

          ],

        ),
      ),
    );
  }
}
