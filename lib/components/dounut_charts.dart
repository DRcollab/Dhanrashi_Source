

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Task{
  String task = '';
  double value = 0;
  Color color = Color(0);
  Task(this.task,this.value,this.color);


}


class DonutChart extends StatelessWidget {


 List<Task> pieData = [];


  DonutChart( {required this.pieData}  );



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

    return charts.PieChart<String>(
      List.from(seriesPieData),
      animate: true,

      animationDuration: Duration(milliseconds: 200),
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 30,
          arcRendererDecorators: [

            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside,
            )
          ],

      )
      ,
    );
  }
}