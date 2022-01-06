
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/goal_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../chart_viewer.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import '../empty_page_inputs.dart';
import 'shingle.dart';
import 'maps.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:sizer/sizer.dart';


class GoalsTabView extends StatefulWidget {
  //GoalsTabView({Key? key}) : super(key: key);
  //FirebaseFirestore fireStore;
  late List<GoalDB>  goalDBs;
 // int longestGoalDuration;
  //int longestInvestmentDuration;
  var currentUser;
  double totalAmount;
  List<GlobalKey?>? showCaseKey;

  GoalsTabView({

    required this.goalDBs,
    required this.currentUser,
    this.totalAmount=0,
    //this.longestInvestmentDuration = 0,
   // this.longestGoalDuration=0,
    this.showCaseKey,
  });


  @override
  _GoalsTabViewState createState() => _GoalsTabViewState();
}

class _GoalsTabViewState extends State<GoalsTabView> {

  bool isComplete = false;
  bool fetched = false;
  bool moveKB = false;
  String prefix = '';
  double totalGoal = 0;
  double totalCorpus = 0;
  // int longestInvestmentDuration = 0;
  // int longestGoalDuration = 0;

  late FirebaseFirestore fireStore;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    totalGoal = widget.totalAmount;
    goals = List.empty(growable: true);
    if(widget.goalDBs.isNotEmpty){
      widget.goalDBs.forEach((element) {

        goals.add(element.goal);

      });
      //longestGoalDuration = Calculator().getLongestGoalDuration(goals);

      dataSet = Calculator().getGoalDetail(goals,Global.longestInvestmentDuration, Global.longestGoalDuration);
      fetched = true;
    }else{

      fetched = false;
    }
    //
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
     // goalAccess = DRGoalAccess(fireStore, widget.currentUser);
    });
  }





  _edit(int index, String type){
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
              type: type,
              onUpdate: (newGoal){

                setState(() {
                  if(type!='Delete') {
                    goals[index] = newGoal!;
                    widget.goalDBs[index].goal = goals[index];
                  }else{
                    goals.removeAt(index);
                    widget.goalDBs.removeAt(index);
                  }
                  totalGoal = 0;
                  if(goals.isNotEmpty) {
                    goals.forEach((element) {
                      totalGoal = element.goalAmount + totalGoal;

                      double futureValue = Calculator.fv(element.inflation, element.duration,element.goalAmount,
                          0, 0);

                      totalCorpus = futureValue + totalCorpus;


                    });

                    Global.longestGoalDuration = Calculator().getLongestGoalDuration(goals);
                    dataSet.clear();
                    dataSet = Calculator().getGoalDetail(
                      goals, Global.longestInvestmentDuration, Global.longestGoalDuration,);
                  }
                  else{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EmptyPage(currentUser: widget.currentUser,)));
                  }
                });

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






    return Column(

      children: [
        Flexible(
          flex:2,
          child:Showcase(
                  key:widget.showCaseKey![0]!,
                  description: 'Click here to view the data in tabular form',
                  title: 'Your goals in a chart',
                  child: Container(

                      child: fetched ? Stack(

                        children: [
                         goals.isNotEmpty ?DynamicGraph(
                            chartType: ChartType.bar,
                            resultSet: dataSet,
                            gallopYears: (Global.longestGoalDuration~/5),
                          ):SizedBox(),
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

        ),
        Flexible(
          flex:1,
          child: ListTile(
           // leading: FaIcon(FontAwesomeIcons.list),
            title: Text('Total Goal: ${
                totalGoal<DefaultValues.threshold? DefaultValues.textFormatWithDecimal.format(totalGoal)
                :DefaultValues.textShortFormat.format(totalGoal)}'

              , style: DefaultValues.kH3(context),),
            trailing: Showcase(
              key: widget.showCaseKey![1]!,
              description: 'Click here to add a new goal',
              child: RoundButton(
                icon: Icons.add,
                  onPress:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GoalsInputScreen(currentUser: widget.currentUser,)));
                  }
              ),
            ),



          ),
        ),
        Container(
         height: 50.h, //* DefaultValues.adaptByValue(context,0.50),
          child: ListView.builder(
              itemBuilder: (context, index){

                return Padding(
                  padding:  EdgeInsets.only(left:2.w,right: 2.w),
                  child: Showcase(
                    key:index==0 ? widget.showCaseKey![2]!: new GlobalKey(),
                    title: 'Summary of the Goal',
                    description: 'Click this area to view and update the goal',
                    child: Shingle(
                      onPressed:(){

                        if(prefixSymbols.contains(goals[index].name.substring(0,1))){
                          prefix=goals[index].name.substring(0,1);

                        }else{
                          prefix=symbols[goals[index].name.trim()];
                        }
                        _edit(index, 'Update');
                      },
                      type: 'goal',
                      maxHeight: 11.h,
                      barColor: DefaultValues.graphColors[index%15],
                      leadingImage: goalIcons.containsKey(this.goals[index].name)
                          ?goalIcons[this.goals[index].name]
                          :goalIcons[this.goals[index].name.substring(0,1)],
                      title:  prefixSymbols.contains(goals[index].name.substring(0,1))
                          ?goals[index].name.substring(1)
                          :goals[index].name,
                      prefix: prefixSymbols.contains(goals[index].name.substring(0,1))
                          ?goals[index].name.substring(0,1)
                          :'',
                //Utility.changeToPeriodicDecimal(goals[index].goalAmount).toString()} ${Utility.getPeriod(goals[index].goalAmount)
                      subtitle: 'Goal: ${DefaultValues.textFormat.format(goals[index].goalAmount)}',
                      value:'${goals[index].duration.toString()} Years',
                      icon1:Icons.watch_later_outlined,
                      trailing: Showcase(
                        key: index==0 ? widget.showCaseKey![3]! : new GlobalKey(),
                        //shapeBorder: Shape,
                        contentPadding: EdgeInsets.all(10),
                        description: 'Click here to delete',
                        child: IconButton(
                            icon: Icon(Icons.delete, size:16.sp) ,
                          onPressed: (){
                            _edit(index, 'Delete');
                              // Utility.showMessageAndAsk(
                              //     context: context,
                              //     buttonText1: 'I know',
                              //     buttonText2: 'Cancel',
                              //     msg:'Beware! You are about to delete this goal. This action is irreversible',
                              //     takeAction1: (){
                              //       GoalDB goalDB = widget.goalDBs[index];
                              //       _delete(goalDB);
                              //
                              //
                              //     },
                              //     takeAction2: (){},
                              // );
                          },


                        ),
                      ),

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
