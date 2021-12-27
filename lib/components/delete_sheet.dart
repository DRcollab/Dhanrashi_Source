
import 'dart:math';
import 'package:dhanrashi_mvp/components/vanish_keyboard.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/components/work_done.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:dhanrashi_mvp/components/maps.dart';

import 'labelled_input.dart';




class DeleteSheet extends StatefulWidget {

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

  DeleteSheet({

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
  _DeleteSheetState createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<DeleteSheet> {

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
  double inflationEffect = 1.0;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController dummy = TextEditingController();
  late FirebaseFirestore fireStore;





  // double fv(double r, int nper, double pmt, double pv, int type){
  //
  //   double fv = (pv * pow(1 + r, nper ) + pmt * (1 + r * type)*(pow(1+r, nper) -1 )/r);
  //   return fv;
  // }



  @override
  void initState(){

    this.isSavePressed = false;
    this.statusOfStoring = false;
    this.isTimedOut = false;
    goalAmount = widget.goalAmount;
    inflation = widget.inflation;
    goalDuration = widget.goalDuration;


    super.initState();
    // _audioCache = AudioCache(
    //   prefix: 'audio/',
    //   fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    // );

    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;

    });


  }


  // double calculateInterset( ){
  //
  //   double interest;
  //   // double roi = expectedRoi /100;
  //   futureValue = fv(inflation/100,goalDuration, 0, goalAmount, 0);
  //   double goalPortion = goalAmount;
  //
  //   double _inflation = futureValue - goalPortion;
  //
  //
  //   return double.parse(_inflation.toStringAsFixed(1)) ;
  //
  // }





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

   // inflationEffect = calculateInterset();
    // totalInvestment = investedAmount + annualInvestment*investmentDuration;

    pieData = [

      Task('Goal', goalAmount, kPresentTheme.accentColor),
      Task('Inflation Effect', inflationEffect ,kPresentTheme.alternateColor),


    ];


    return isSavePressed ? WorkDone(isComplete: statusOfStoring,whatToAdd: 'Goal', whatToDo: widget.type,timedOut: isTimedOut,) : VanishKeyBoard(
      onTap: (){
        print('clicked');
        setState(() {

          isEditing = false;

          goalAmount = double.parse(dummy.text);
          dummy.text = DefaultValues.textFormat.format(double.parse(dummy.text));


        });

        print('clicked');
      },
      child: Container(
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
                        child: Text(widget.titleMessage, style: DefaultValues.kH2(context),)
                      ),
                      ),
                      //
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
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (goalAmount+inflationEffect)<DefaultValues.threshold ? '${DefaultValues.textFormatWithDecimal.format(goalAmount)}'
                                :'${DefaultValues.textShortFormat.format(goalAmount)}'
                            ,style: DefaultValues.kH3(context),)),
                      Row(
                        children: [
                          Container(height: 10, width: 12 ,color: kPresentTheme.alternateColor),
                          Padding(
                            padding:  EdgeInsets.only(left : 2.w),
                            child: Text('Inflationary Effect'),
                          ),

                        ],
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (goalAmount+inflationEffect)<DefaultValues.threshold ? '${DefaultValues.textFormatWithDecimal.format(inflationEffect)}'
                                :'${DefaultValues.textShortFormat.format(inflationEffect)}',
                            style: DefaultValues.kH3(context),)),
                      SizedBox(height: 0.6.h,width: double.infinity,),
                      Container(height: 0.2.h,width: double.infinity,color: Colors.black12,),
                      SizedBox(height: 0.5.h,width: double.infinity,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          (goalAmount+inflationEffect)<DefaultValues.threshold ?'${DefaultValues.textFormat.format(goalAmount+inflationEffect)}'
                              :'${DefaultValues.textShortFormat.format(goalAmount+inflationEffect)}',
                          style: DefaultValues.kH2(context),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left:2.w, right: 2.w),
              child: Card(
                child: Text( DefaultValues.textFormatWithDecimal.format(goalAmount), style: DefaultValues.kH2(context),),
              )
            ),

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
      ),
    );
  }
}




