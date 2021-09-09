import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'shingle.dart';
import 'maps.dart';

class GoalsTabView extends StatelessWidget {
  //GoalsTabView({Key? key}) : super(key: key);

  late List<GoalDB>  goals;
  var currentUser;
  double totalAmount;
  GoalsTabView({required this.goals, required this.currentUser,this.totalAmount=0});

  final   pieData = [

    Task('Investment', 21, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),
    Task('Car', 10 ,Colors.black26),

  ];


  // Column(
  // children: [
  // Container(
  // height: 200,
  // width: 200,
  // child: DonutChart(pieData: pieData
  // )
  // ),
  //
  // Container(
  // height: 400,
  // child: ListView(
  // children: [
  //
  //
  //
  // ],
  // ),
  // )
  // ],
  // );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            width: 150,
            child: DonutChart(pieData: pieData
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Total Goal Amount: ${totalAmount}'),
            FloatingActionButton(
                backgroundColor: kPresentTheme.accentColor,
                child: Icon(Icons.add),
                mini: true,
                onPressed:(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoalsInputScreen(currentUser: currentUser,)));
                }
            )
          ],
        ),
        Container(
          height: 400,
          child: ListView.builder(
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Shingle(
                    leadingImage: goalIcons[goals[index].goal.name],
                    title:  goals[index].goal.name,
                    subtitle: goals[index].goal.goalAmount.toString(),
                    value:goals[index].goal.duration.toString()
                  ),
                );

              },
            itemCount: goals.length,

          ),

        ),


      ],
    );
  }
}
