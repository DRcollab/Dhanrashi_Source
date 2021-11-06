import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'components/constants.dart';


class FolioManager extends StatelessWidget {

  var currentUser;
  FolioManager({
    this.currentUser,
});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
          child: Container(
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
              labelStyle: DefaultValues.kH4(context),

              tabs: [
                Tab(text:'Goals'),
                Tab(text: 'Investments',),

              ],
            ),

          ),
              foot: TabBar(
                  tabs:[

                  ]
      ),
      ),
    );
  }
}
