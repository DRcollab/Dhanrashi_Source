import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/investmentinput.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_gifs/loading_gifs.dart';
import '../chart_view.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'investment_entry_sheet.dart';
import 'shingle.dart';
import 'maps.dart';
import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:sizer/sizer.dart';


class GoalsTabView extends StatefulWidget {
  //GoalsTabView({Key? key}) : super(key: key);
  //FirebaseFirestore fireStore;
  late List<GoalDB>  goalDBs;
  int longestGoalDuration;
  int longestInvestmentDuration;
  var currentUser;
  double totalAmount;

  GoalsTabView({

    required this.goalDBs,
    required this.currentUser,
    this.totalAmount=0,
    this.longestInvestmentDuration = 0,
    this.longestGoalDuration=0});

  @override
  _GoalsTabViewState createState() => _GoalsTabViewState();
}

class _GoalsTabViewState extends State<GoalsTabView> {

  bool fetched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    goals = List.empty(growable: true);
    if(widget.goalDBs.length>0){
      widget.goalDBs.forEach((element) {

        goals.add(element.goal);

      });
      fetched = true;
      dataSet = Calculator().getGoalDetail(goals,widget.longestInvestmentDuration, widget.longestGoalDuration);

    }else{

      fetched = false;
    }
    //


  }



  List dataSet = List.empty(growable: true);

   List<Goal> goals = [];

   List names  = [];

  @override
  Widget build(BuildContext context) {



   print('length is : ${goals}');
  // print('another is ${_goalList}');

    return Column(

      children: [
        Flexible(
          flex:2,
          child: Container(

              height: 20.h,
              width: 450,
              child: fetched ? Stack(

                children: [
                  DynamicGraph(
                    chartType: ChartType.bar,
                    resultSet: dataSet,
                    gallopYears: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChartView(
                                chartChild: DynamicGraph(
                                  isVertical: false,
                                  chartType: ChartType.bar,
                                  resultSet: dataSet,
                                  gallopYears: 1,
                                ),

                              )));
                    },
                    child: Container(
                      color: Color(0x00000000),
                      height: 20.h,
                      width: 100.w,
                    ),
                  ),
                ],
              ) : Image.asset(circularProgressIndicator, scale: 3),
            //DonutChart(pieData: pieData)
          ),
        ),
        Flexible(
          flex:1,
          child: ListTile(
           // leading: FaIcon(FontAwesomeIcons.list),
            title: Text('Total Goal Amount: ${widget.totalAmount.toStringAsFixed(2)}', style: DefaultValues.kNormal3(context),),
            trailing: RoundButton(
              icon: Icons.add,
                onPress:(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoalsInputScreen(currentUser: widget.currentUser,)));
                }
            ),



          ),
        ),
        Container(
         height: 50.h, //* DefaultValues.adaptByValue(context,0.50),
          child: ListView.builder(
              itemBuilder: (context, index){
                return Padding(
                  padding:  EdgeInsets.only(left:2.w,right: 2.w),
                  child: Shingle(

                    type: 'goal',
                    maxHeight: 8.h,
                    barColor: DefaultValues.graphColors[index%15],
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
                                  uniquId: widget.goalDBs[index].goalDocumentID,
                                  currentUser: this.widget.currentUser,
                                  titleMessage: goals[index].name,
                                  goalAmount: goals[index].goalAmount,
                                  goalDuration: goals[index].duration,
                                  inflation: goals[index].inflation * 100,
                                  imageSource: 'images/destination.png',
                                  type: 'Update',
                                  onUpdate: (newGoal){
                                    print('new inv amount');
                                    setState(() {
                                      goals[index] = newGoal!;
                                    });
                                    print('${goals[index].goalAmount}, ${goals[index].duration}');
                                  },
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
