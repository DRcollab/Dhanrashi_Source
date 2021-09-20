import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'investment_entry_sheet.dart';
import 'shingle.dart';
import 'maps.dart';
import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';


class GoalsTabView extends StatelessWidget {
  //GoalsTabView({Key? key}) : super(key: key);

  late List<GoalDB>  goalDBs;
  List dataSet = List.empty(growable: true);
  int longestGoalDuration;
  int longestInvestmentDuration;
  var currentUser;
  double totalAmount;
  GoalsTabView({required this.goalDBs, required this.currentUser,this.totalAmount=0, this.longestInvestmentDuration = 0, this.longestGoalDuration=0});
   List<Goal> goals = [];
   List names  = [];
  final   pieData = [

    Task('Investment', 21, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),
    Task('Car', 10 ,Colors.black26),

  ];




  @override
  Widget build(BuildContext context) {

    bool fetched = false;
    goals = List.empty(growable: true);
    if(goalDBs.length>0){
      goalDBs.forEach((element) {

        goals.add(element.goal);

      });
      fetched = true;
      dataSet = Calculator().getGoalDetail(goals,longestInvestmentDuration, longestGoalDuration);

    }else{

      fetched = false;
    }




   print('length is : ${goals}');
  // print('another is ${_goalList}');

    return Column(
      children: [
        Container(
            height: 150,
            width: 450,
            child: fetched ? DynamicGraph(
              chartType: ChartType.bar,
              resultSet: dataSet,
            ) : Image.asset(circularProgressIndicator, scale: 3),
          //DonutChart(pieData: pieData)
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
         height: 400 * DefaultValues.adaptForSmallDevice(context),
          child: ListView.builder(
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Shingle(
                    leadingImage: goalIcons[goals[index].name],
                    title:  goals[index].name,
                    subtitle: 'Goal: ${goals[index].goalAmount.toString()} Lakh INR',
                    value:'Duration : ${goals[index].duration.toString()} Years',
                    trailing: IconButton(
                        icon: Icon(Icons.edit) ,
                      onPressed: (){
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: GoalSheet(
                                  uniquId: goalDBs[index].goalDocumentID,
                                  currentUser: this.currentUser,
                                  titleMessage: goals[index].name,
                                  goalAmount: goals[index].goalAmount,
                                  goalDuration: goals[index].duration,
                                  inflation: goals[index].inflation * 100,
                                  imageSource: 'images/destination.png',
                                  type: 'Update',
                                ),
                              ),
                            ));
                      },


                    ),

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
