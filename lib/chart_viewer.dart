import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'components/chart_tab_view.dart';
import 'components/constants.dart';
import 'components/table_view.dart';
import 'data/show_graph_dynamic.dart';


class ChartViewer extends StatefulWidget {

 // late Widget chartChild;
  List dataSet;
  List? dataSetForTable;
  var currentUser;
  ChartType type;
  bool useFirstColumnFromList = false;
  ChartViewer(
  {
    required this.dataSet,
    this.dataSetForTable,
    this.currentUser,
    this.type = ChartType.bar,
    this.useFirstColumnFromList = false,
  }
      );

  @override
  _ChartViewerState createState() => _ChartViewerState();
}

class _ChartViewerState extends State<ChartViewer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.dataSetForTable == null){
      widget.dataSetForTable = widget.dataSet;
    }

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        currentUser: widget.currentUser,
        rightButton: IconButton(icon: Icon(Icons.close),
          onPressed: (){
              Navigator.pop(context);
          },
        ),
        child:Padding(
          padding: EdgeInsets.only(top:4.h),
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
                color: kPresentTheme.alternateColor,
                //tabPosition: TabPosition,
                paintingStyle: PaintingStyle.fill,
                strokeWidth: 10,
              ),
              indicatorColor: kPresentTheme.accentColor,
              labelColor: Colors.black,
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
            ChartTabView(
              currentUser: widget.currentUser,
              chartChild: DynamicGraph(
                isVertical: false,
                chartType: widget.type,
                resultSet: widget.dataSet,
                gallopYears: 1,
              ),
            ),
            TableView(
              arrayList: widget.dataSetForTable!,
              useFirstColumnFromList: widget.useFirstColumnFromList,
            ),

          ],

        ),
      ),
    );
  }
}
