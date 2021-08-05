

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Task{
  String task = '';
  double value = 0;
  Color color = Color(0);


  Task(this.task,this.value,this.color);

}


class DonutChart extends StatefulWidget {
  // const DonutChart({Key? key}) : super(key: key);

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {


  var seriesPieData;


  generateData(){

    var pieData = [
      Task('Work', 35.8, Colors.deepPurpleAccent),
      Task('Play', 24.8,Colors.amberAccent),
      Task('Rest',19.0,Colors.green),
    ];

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
  void initState() {

    super.initState();
    seriesPieData  = <charts.Series<Task, String>>[];
    generateData();

  }


  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
      List.from(seriesPieData),
      animate: true,
      animationDuration: Duration(milliseconds: 400),
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 30,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside,
            )
          ]
      )
      ,
    );
  }
}