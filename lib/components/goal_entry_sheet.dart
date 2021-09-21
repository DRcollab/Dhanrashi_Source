
import 'dart:math';

import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/goal_access.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal_db.dart';
import 'package:flutter/material.dart';
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

// double investedAmount = 10;
// double expectedRoi = 23;
// int investmentDuration = 8;


class GoalSheet extends StatefulWidget {
  // const ActionSheet({Key? key}) : super(key: key);

  String titleMessage;
  double goalAmount = 0;
  int goalDuration = 0;
  double inflation = 4.5;
  String imageSource ='';
  String display = '';
  String? uniquId;
  late var currentUser;
  late String type='Save';
  // final String? Function(String?) validator => return 0;

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
  });

  @override
  _GoalSheetState createState() => _GoalSheetState();
}

class _GoalSheetState extends State<GoalSheet> {

  //var seriesPieData =  <charts.Series<Task, String>>[];
  List<Task> pieData = [];

  //String display = '';
  double sliderValue = 5;
  double futureValue = 0;
  double goalAmount = 1;
  double inflation = 1;
  int goalDuration = 1;
 // double interestValue = 0 ;        // holds calculated value of futureValue of the investment
 // double annualInvestment = 0;
  // Investment currentInvestment = Investment();
  late FirebaseFirestore fireStore;
  late var goalAccess;

  // double calculateInterset( ){
  //
  //   double interest;
  //   // double roi = expectedRoi /100;
  //   futureValue = fv(expectedRoi/100,investmentDuration, annualInvestment, investedAmount, 0);
  //   double investedPortion = investedAmount + annualInvestment * investmentDuration;
  //
  //   interest = futureValue - investedPortion;
  //
  //
  //   return double.parse(interest.toStringAsFixed(1)) ;
  //
  // }

//TODO
  double fv(double r, int nper, double pmt, double pv, int type){

    double fv = (pv * pow(1 + r, nper ) + pmt * (1 + r * type)*(pow(1+r, nper) -1 )/r);
    return fv;
  }



  @override
  void initState(){

    // print(widget.investmentDuration);
    goalAmount = widget.goalAmount;
    inflation = widget.inflation;
    goalDuration = widget.goalDuration;
   // interestValue = calculateInterset();
   // annualInvestment = widget.annualInvestment;

    super.initState();
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      goalAccess = DRGoalAccess(fireStore, widget.currentUser);
    });

    // print(fireStore.toString());
  }

  void _update(GoalDB goalDB) async {
    try{
      await goalAccess.updateGoalSolo(goalDB,'Active');
    }
    catch(e){
      Utility.showErrorMessage(context, e.toString());
    }


  }


  void _save(Goal goal) async {
    final snackBar = SnackBar(
      content: Text(' Your investments are saved successfully'),
    );
    print(fireStore.toString());

 // DRGoalAccess().fetchGoals();

    try{
      await goalAccess.storeGoalSolo(goal);
      // Fluttertoast.showToast(
      //     msg:'Saved successfully',
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.CENTER,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    catch(e){
      Utility.showErrorMessage(context, e.toString());

    }
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

    //print(fireStore.toString());
   // interestValue = calculateInterset();

    //  print('PV : $investedAmount and IV:$interestValue');

    pieData = [

      Task('Investment', goalAmount, kPresentTheme.accentColor),
      Task('Interest Earned', inflation ,kPresentTheme.alternateColor),


    ];


    return Container(
      color: Color(0x00000000),
      child: Wrap(
        // shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(widget.imageSource, height: 50, width: 50,),
                    Expanded(child: Center(child: Text(widget.titleMessage, style: DefaultValues.kH1(context),))),
                    CommandButton(
                      buttonColor: kPresentTheme.alternateColor,
                      //icon: Icons.save,
                      textColor: kPresentTheme.highLightColor,
                      textSize: 20 * DefaultValues.adaptFontsForSmallDevice(context),
                      buttonText: widget.type,
                      onPressed:()  {



                        var goal =  Goal(
                          name:widget.titleMessage,
                          description: 'No description',
                          goalAmount: goalAmount,
                          duration: goalDuration,
                          inflation: inflation/100,
                        );

                        print('.... printing inv:;;;;;;;;');
                      //  print(inv);

                        setState(() {

                          if(widget.type == 'Save')
                         _save(goal);
                          else{
                            print("from click--================>");
                            print(widget.currentUser.email,);
                          print(widget.currentUser.uid);
                          print(widget.uniquId);
                          var  goalDB = GoalDB(
                              email: widget.currentUser.email,
                              user: widget.currentUser.uid,
                              goalDocumentID: widget.uniquId!,
                              goal:goal,

                            );
                          _update(goalDB);
                          }

                        });

                        Navigator.pop(context);


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
                  height: 180 * DefaultValues.adaptForSmallDevice(context),
                  width: 180 * DefaultValues.adaptForSmallDevice(context),
                  child: DonutChart(pieData: pieData,)),
              Container(
                height: 180 * DefaultValues.adaptForSmallDevice(context),
                width: 180 * DefaultValues.reduceWidthAsPerScreen(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30 * DefaultValues.adaptForSmallDevice(context),),
                    Row(
                      children: [
                        Container(
                            height: 10 * DefaultValues.adaptForSmallDevice(context),
                            width: 12 * DefaultValues.reduceWidthAsPerScreen(context) ,
                            color: kPresentTheme.accentColor),
                        Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('Goal Amount'),
                        ),

                      ],
                    ),
                    Text('${goalAmount} Lakh',style: DefaultValues.kH3(context),),
                    Row(
                      children: [
                        Container(height: 10, width: 12 ,color: kPresentTheme.alternateColor),
                        Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text('inflation Amount'),
                        ),

                      ],
                    ),
                    Text('${inflation} Lakh',style: DefaultValues.kH3(context),),
                    SizedBox(height: 5,width: double.infinity,),
                    Container(height: 2,width: double.infinity,color: Colors.black12,),
                    SizedBox(height: 5,width: double.infinity,),
                    Text('${(goalAmount+inflation).toStringAsFixed(2)} Lakh',
                      style: DefaultValues.kH1(context),
                    ),
                  ],
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){

                setState(() {
                  goalAmount = value;
                });

              },

              validator: (value){

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
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  inflation = value;
                });

              },

              validator: (value){

              },
              min: 1,
              max:30,
              labelText: 'Inflation',
              sliderValue: inflation,
              suffix: '%      ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  goalDuration = value.round();
                });

              },


              validator: (value){

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




