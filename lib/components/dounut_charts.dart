

import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';

class Task{
  String task = '';
  double value = 0;
  Color color = Color(0);
  Task(this.task,this.value,this.color);


}


class DonutChart extends StatelessWidget {

 List<Task> pieData = [];
 int arcWidth = 35;
 bool viewLabel = false;

  DonutChart( {required this.pieData, this.arcWidth = 35, this.viewLabel = false}  );



  List<charts.Series<Task, String>>seriesPieData  = [];


  generateData(){



    seriesPieData.add(
          charts.Series(
          data: pieData,
          domainFn: (Task task,_) => task.task,
          measureFn: (Task task,_) => task.value,
          colorFn: (Task task,_) => charts.ColorUtil.fromDartColor(task.color),

          id:'daily_task',
          labelAccessorFn: (Task row,_) =>'${row.value}',


        )
    );
  }




  @override
  Widget build(BuildContext context) {
   generateData();
    print('From inside Pie Chart : ${seriesPieData[0].data[0].task}');
    print('From inside Pie Chart : ${seriesPieData[0].data[1].task}');

    if(seriesPieData.length>1){
      print('length > 1');
      print('From inside Pie Chart : ${seriesPieData[1].data[0].task}');
      print('From inside Pie Chart : ${seriesPieData[1].data[1].task}');
    }

    return charts.PieChart<String>(
      List.from(seriesPieData),
      animate: true,

      animationDuration: Duration(milliseconds: 200),
      // behaviors: [
      //
      //   charts.DatumLegend(
      //     outsideJustification: charts.OutsideJustification.middleDrawArea,
      //     horizontalFirst: false,
      //     desiredMaxColumns: 2,
      //    // cellPadding: EdgeInsets.only(right: 4.0,bottom: 4.0),
      //    // entryTextStyle:
      //
      //   ),
      //
      // ],
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: (this.arcWidth * DefaultValues.adaptByValue(context, 0.8)).ceil(),
         // startAngle: 4 / 5 * pi,
         // arcLength: 7 / 5 * pi,
          arcRendererDecorators: viewLabel ? [

            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto
            )
          ] : [],



      )
      ,
    );
  }
}