
import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import '../chart_viewer.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'shingle.dart';
import 'maps.dart';
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
  bool moveKB = false;
  String prefix = '';
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


  _edit(int index){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: !moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
            child: GoalSheet(
              prefix: this.prefix,
              onEditCommit: (){
                setState(() {
                  moveKB = false;
                });
              },
              onTap: (){
                setState(() {
                  moveKB = true;
                });
              },
              uniquId: widget.goalDBs[index].goalDocumentID,
              currentUser: this.widget.currentUser,
              titleMessage: '#@:%&^*!'.contains(goals[index].name.substring(0,1))
                  ?goals[index].name.substring(1)
                  :goals[index].name,
              goalAmount: goals[index].goalAmount,
              goalDuration: goals[index].duration,
              inflation: goals[index].inflation * 100,
              imageSource: goalIcons.containsKey(this.goals[index].name)
                  ?goalIcons[this.goals[index].name]
                  :goalIcons[this.goals[index].name.substring(0,1)],
              type: 'Update',
              onUpdate: (newGoal){
                print('new inv amount');
                setState(() {
                  goals[index] = newGoal!;
                  widget.goalDBs[index].goal = goals[index];
                });
                print('${goals[index].goalAmount}, ${goals[index].duration}');
              },
            ),
          ),
        ));
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

              child: fetched ? Stack(

                children: [
                  DynamicGraph(
                    chartType: ChartType.bar,
                    resultSet: dataSet,
                    gallopYears: (widget.longestGoalDuration~/5),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChartViewer(
                                currentUser: widget.currentUser,
                                dataSet: dataSet,

                              )));
                    },
                    child: Container(
                      color: Color(0x00000000),
                      height: 20.h,
                      width: 100.w,
                    ),
                  ),
                ],
              ) : Image.asset(kPresentTheme.progressIndicator, scale: 3),
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
                    onPressed:(){
                      if('#@:%&^*!'.contains(goals[index].name.substring(0,1))){
                        prefix=goals[index].name.substring(0,1);

                      }else{
                        prefix='';
                      }
                      _edit(index);
                    },
                    type: 'goal',
                    maxHeight: 11.h,
                    barColor: DefaultValues.graphColors[index%15],
                    leadingImage: goalIcons.containsKey(this.goals[index].name)
                        ?goalIcons[this.goals[index].name]
                        :goalIcons[this.goals[index].name.substring(0,1)],
                    title:  '#@:%&^*!'.contains(goals[index].name.substring(0,1))
                        ?goals[index].name.substring(1)
                        :goals[index].name,
                    prefix: '#@:%&^*!'.contains(goals[index].name.substring(0,1))
                        ?goals[index].name.substring(0,1)
                        :'',
                //Utility.changeToPeriodicDecimal(goals[index].goalAmount).toString()} ${Utility.getPeriod(goals[index].goalAmount)
                    subtitle: 'Goal: ${DefaultValues.textFormat.format(goals[index].goalAmount)}',
                    value:'${goals[index].duration.toString()} Years',
                    icon1:Icons.watch_later_outlined,
                    trailing: IconButton(
                        icon: Icon(Icons.edit) ,
                      onPressed: (){

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
