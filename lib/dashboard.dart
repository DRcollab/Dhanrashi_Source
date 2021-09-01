

import 'package:dhanrashi_mvp/components/analytics_tabview_class.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/goal_tabview_class.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/data/user_data_class.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'investmentinput.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/investment_tabview_class.dart';


class Dashboard extends StatelessWidget {

  DRUserAccess? currentUser;

  Dashboard({required this.currentUser});




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 3,
          child: CustomScaffold(
              title: 'Dashboard',
              child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Material(

                  child: TabBar(

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
                    tabs: [
                      Tab(text:'Analytics'),
                      Tab(text:'Goals'),
                      Tab(text: 'Investments',),

                    ],

            ),
                ),
              ),
            body: TabBarView(
              children: [
               // AnalyticsTabView(),
                AnalyticsTabView(),
                GoalsTabView(),// 2nd view
                InvestmentTabView(),

              ]
            ),
          ),

    );

  }
}
