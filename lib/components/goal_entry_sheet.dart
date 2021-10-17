
import 'dart:math';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/components/work_done.dart';
import 'package:dhanrashi_mvp/data/goal_access.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import 'band_class.dart';
import 'custom_text_field.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dhanrashi_mvp/components/labeled_slider.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:sizer/sizer.dart';




class GoalSheet extends StatefulWidget {

  String prefix = '';
  String titleMessage;
  double goalAmount = 0;
  int goalDuration = 0;
  double inflation = 4.5;
  String imageSource ='';
  String display = '';
  String? uniquId;
  late var currentUser;
  late String type='Save';
  Function(Goal? goal)? onUpdate;
  Function(dynamic)? onAdd;
  late Function()? onTap;
  late Function() onEditCommit;

  GoalSheet({

    this.titleMessage='',
    required this.goalAmount,
    required this.inflation,
    required this.goalDuration,

    this.imageSource='',

    //  required this.save,
    this.uniquId,
    required this.currentUser,
    this.type = 'Save',
    this.onUpdate,
    this.onAdd,
    required this.onEditCommit,
    this.onTap,
    required this.prefix,
  });

  @override
  _GoalSheetState createState() => _GoalSheetState();
}

class _GoalSheetState extends State<GoalSheet> {

  //var seriesPieData =  <charts.Series<Task, String>>[];
  bool isSavePressed = false;
  bool isTimedOut = false;
  List<Task> pieData = [];
  bool isEditing = false;
  bool statusOfStoring = false;
  //String display = '';
  double sliderValue = 5;
  double futureValue = 0;
  double goalAmount = 1;
  double inflation = 1;
  int goalDuration = 1;
  TextEditingController editingController = TextEditingController();

  late FirebaseFirestore fireStore;
  late var goalAccess;




  double fv(double r, int nper, double pmt, double pv, int type){

    double fv = (pv * pow(1 + r, nper ) + pmt * (1 + r * type)*(pow(1+r, nper) -1 )/r);
    return fv;
  }



  @override
  void initState(){

    this.isSavePressed = false;
    this.statusOfStoring = false;
    this.isTimedOut = false;
    goalAmount = widget.goalAmount;
    inflation = widget.inflation;
    goalDuration = widget.goalDuration;

    print(' I am in Init Tstae of goal entry');
    super.initState();
    // _audioCache = AudioCache(
    //   prefix: 'audio/',
    //   fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    // );

    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      goalAccess = DRGoalAccess(fireStore, widget.currentUser);
    });


  }

  Future _update(GoalDB goalDB) async {


    DateTime currentPhoneDate = DateTime.now();
    print(' i am in update');

    var docID = goalDB.goalDocumentID;
    print(' i am in update ${docID}');

      fireStore.collection('pjdhan_goal').doc(docID).update({
        'email': goalDB.email,
        'Uuid': goalDB.user,
        'Updated_id': 'system',
        'goal_name': goalDB.goal.name,
        'goal_description': goalDB.goal.description,
        'goal_duration': goalDB.goal.duration,
        'goal_amount': goalDB.goal.goalAmount,
        'insert_dts': Timestamp.fromDate(currentPhoneDate),
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': 'Active',
      }).whenComplete((){
        setState(() {
              statusOfStoring = true;
              widget.onUpdate!(goalDB.goal);

            });
      }).catchError((onError){
          Utility.showErrorMessage(context, e.toString());
        });


  }


  Future _save(Goal goal) async {

    DateTime currentPhoneDate = DateTime.now();

      await fireStore.collection('pjdhan_goal').add({
        'email': widget.currentUser.email,
        'Uuid': widget.currentUser.uid,
        'Updated_id': 'system',
        'goal_name': goal.name,
        'goal_description': goal.description,
        'goal_duration': goal.duration,
        'goal_amount': goal.goalAmount,
        'inflation': goal.inflation,
        'insert_dts': Timestamp.fromDate(currentPhoneDate),
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': 'Active',
      }).whenComplete((){
        setState(() {
                statusOfStoring = true;
                Global.goalCount++;
                widget.onAdd!(Global.goalCount);
              });
      }).catchError((onError){
            Utility.showErrorMessage(context, e.toString());
          });

  }



  void _updateGoalSolo( GoalDB goalDB, String docStatus ) async {
    DateTime currentPhoneDate = DateTime.now();

    var docID= goalDB.goalDocumentID;
    try {
      fireStore.collection('pjdhan_goal').doc(docID).update({
        'email': goalDB.email,
        'Uuid': goalDB.user,
        'Updated_id': 'system',
        'goal_name': goalDB.goal.name,
        'goal_description': goalDB.goal.description,
        'goal_duration': goalDB.goal.duration,
        'goal_amount': goalDB.goal.goalAmount,
        'insert_dts': Timestamp.fromDate(currentPhoneDate),
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': docStatus
      })
          .then((value)=>print("Goal updated"));
    }
    catch (e) {
      print( 'Exception while updating $docID $e');
    }

  }


  @override
  Widget build(BuildContext context) {



    pieData = [

      Task('Investment', goalAmount, kPresentTheme.accentColor),
      Task('Interest Earned', inflation ,kPresentTheme.alternateColor),


    ];


    return isSavePressed ? WorkDone(isComplete: statusOfStoring,whatToAdd: 'Goal', whatToDo: widget.type,timedOut: isTimedOut,) : Container(
      color: Color(0x00000000),
      child: Wrap(

        children: [
          Container(
            decoration: BoxDecoration(
                color: kPresentTheme.themeColor,//Color(0x00000000),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset.zero,
                    blurRadius: 0.5,
                    spreadRadius: 1,

                  )
                ]
            ),
            child: Padding(
              padding:  EdgeInsets.all(1.w),
              child: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(widget.imageSource, height: 8.h, width: 8.w,),
                    Expanded(child: Center(
                        child: Band(
                          controller:this.editingController,
                          onCommit : widget.onEditCommit,
                          onTap: widget.onTap,
                          text:widget.titleMessage,
                          textStyle: DefaultValues.kH2(context),
                        ),
                    ),
                    ),
                    CommandButton(
                      enabled: !this.isEditing,
                      buttonColor: kPresentTheme.alternateColor,
                      //icon: Icons.save,
                      textColor: kPresentTheme.highLightColor,
                      textSize: 12.sp,
                      buttonText: widget.type,
                      onPressed:()  {



                        var goal =  Goal(
                          name:this.editingController.text.compareTo(widget.titleMessage)==0
                              ?this.editingController.text
                              :widget.prefix+this.editingController.text,
                          description: 'No description',
                          goalAmount: goalAmount,
                          duration: goalDuration,
                          inflation: inflation/100,
                        );

                        print('.... printing inv:;;;;;;;;');
                      //  print(inv);

                        setState(() {

                          if(widget.type == 'Save') {

                           this.isSavePressed = true;

                           Future.any(
                               [
                                  _save(goal),
                                  Utility.timeoutAfter(sec: 10, onTimeout: (){
                                              // Utility.showErrorMessage(context, Utility.messages['timed_out']!);
                                    setState(() {
                                      isTimedOut = true;

                                    });

                                  }),
                               ]
                           );

                          }
                          else{

                          var  goalDB = GoalDB(
                              email: widget.currentUser.email,
                              user: widget.currentUser.uid,
                              goalDocumentID: widget.uniquId!,
                              goal:goal,

                            );
                          this.isSavePressed = true;

                          Future.any(
                              [
                                _update(goalDB),
                                Utility.timeoutAfter(sec: 10, onTimeout: (){
                                  // Utility.showErrorMessage(context, Utility.messages['timed_out']!);
                                  setState(() {
                                    isTimedOut = true;

                                  });


                                }),
                              ]
                          );


                          }

                        });




                        //
                        // print('duration: ${investmentDuration}');
                        // print('amount: ${investedAmount}');
                        // print('ROI :${expectedRoi}');
                        //


                      }, borderRadius: BorderRadius.circular(10),),
                  ],
                ),
              ),
            ),
          ),


          Row(
            children: [

              Container(
                  height: 22.h,//* DefaultValues.adaptForSmallDevice(context),
                  width: 22.h,// * DefaultValues.adaptForSmallDevice(context),
                  child: DonutChart(pieData: pieData,arcWidth:20)),
              Container(
                height: 22.h, //* DefaultValues.adaptForSmallDevice(context),
                width: 22.h, //* DefaultValues.reduceWidthAsPerScreen(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   SizedBox(height: 3.h,),// * DefaultValues.adaptForSmallDevice(context),),
                    Row(
                      children: [
                        Container(
                            height: 1.5.h, //* DefaultValues.adaptForSmallDevice(context),
                            width: 3.w,
                            color: kPresentTheme.accentColor),
                        Padding(
                          padding: EdgeInsets.only(left : 2.w),
                          child: Text('Goal Amount'),
                        ),

                      ],
                    ),
                    Text('${goalAmount} Lakh',style: DefaultValues.kH3(context),),
                    Row(
                      children: [
                        Container(height: 10, width: 12 ,color: kPresentTheme.alternateColor),
                        Padding(
                          padding:  EdgeInsets.only(left : 2.w),
                          child: Text('inflation Amount'),
                        ),

                      ],
                    ),
                    Text('${inflation} Lakh',style: DefaultValues.kH3(context),),
                    SizedBox(height: 0.6.h,width: double.infinity,),
                    Container(height: 0.2.h,width: double.infinity,color: Colors.black12,),
                    SizedBox(height: 0.5.h,width: double.infinity,),
                    Text('${(goalAmount+inflation).toStringAsFixed(2)} Lakh',
                      style: DefaultValues.kH1(context),
                    ),
                  ],
                ),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              onChanged: (value){

                setState(() {
                  goalAmount = value;
                });

              },

              validator: (){
                setState(() {
                  isEditing = true;
                });
              },
              onEditingComplete: (){
                setState(() {
                  isEditing = false;
                });
              },
              sliderValue: goalAmount,
              min: 1,
              max: 100,
              labelText: 'Goal Amount (in Lakhs)',
              suffix: 'Lakhs',
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left:8.0, right: 8.0),
          //   child: LabeledSlider(
          //     onChanged: (value){
          //
          //       setState(() {
          //         annualInvestment = value;
          //       });
          //
          //     },
          //
          //     validator: (value){
          //
          //     },
          //     sliderValue: annualInvestment,
          //     min: 0,
          //     max: 100,
          //     labelText: 'Annual Investment (in Lakhs)',
          //     suffix: 'Lakhs',
          //   ),
          // ),
          Padding(
            padding:  EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              onChanged: (value){
                setState(() {
                  inflation = value;
                });

              },

              validator: (){
                setState(() {
                  isEditing = true;
                });
              },
              onEditingComplete: (){
                setState(() {
                  isEditing = false;
                });
              },
              min: 1,
              max:30,
              labelText: 'Inflation',
              sliderValue: inflation,
              suffix: '%      ',
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              onChanged: (value){
                setState(() {
                  goalDuration = value.round();
                });

              },


              validator: (){
                setState(() {
                  isEditing = true;
                });
              },
              onEditingComplete: (){
                setState(() {
                  isEditing = false;
                });
              },
              min: 1,
              max: 30,
              labelText: 'Goal Period',
              sliderValue: goalDuration.toDouble(),
              textPrecision: 0,
              textEditable: false,
              suffix: 'Years',
            ),
          ),


        ],
      ),
    );
  }
}




