
import 'dart:math';
import 'dart:async';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/components/work_done.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
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
import 'package:sizer/sizer.dart';

// double investedAmount = 10;
// double expectedRoi = 23;
// int investmentDuration = 8;


class InvestmentSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  late String titleMessage;
  late String prefix; // used to determine the type of investment when user has changed the name of the investment
  double investedAmount = 0;
  double expectedRoi = 0;
  int investmentDuration = 0;
  double annualInvestment = 0;
  String imageSource ='';
 // late void Function(dynamic) save;
  String display = '';
  String? uniqueId;
  String type;
  late var currentUser;
  Function(Investment? inv)? onUpdate;
  Function(dynamic)? onAdd;
  late Function()? onTap;
  late Function() onEditCommit;
  // final String? Function(String?) validator => return 0;

  InvestmentSheet({
    this.titleMessage='',
    required this.investedAmount,
    required this.expectedRoi,
    required this.investmentDuration,
    this.imageSource='',
    this.annualInvestment = 1,
  //  required this.save,
    required this.currentUser,
    this.uniqueId,
    this.type = 'Save',
    this.onUpdate,
    this.onAdd,
    this.onTap,
    required this.onEditCommit,
    required this.prefix,
  });

  @override
  _InvestmentSheetState createState() => _InvestmentSheetState();
}

class _InvestmentSheetState extends State<InvestmentSheet> {

  //var seriesPieData =  <charts.Series<Task, String>>[];
  bool isSavePressed = false;
  bool isTimedOut = false;
  bool statusOfStoring = false;
  List<Task> pieData = [];
  bool isEditing = false;
  //String display = '';
  double sliderValue = 5;
  double futureValue = 0;
  double investedAmount = 1;
  double expectedRoi = 1;
  int investmentDuration = 1;
  double interestValue = 0 ;        // holds calculated value of futureValue of the investment
  double annualInvestment = 1;
 // Investment currentInvestment = Investment();
  late FirebaseFirestore fireStore;
  late var investAccess;
  double totalInvestment = 0.0;
  TextEditingController editingController = TextEditingController();

  double calculateInterset( ){

    double interest;
   // double roi = expectedRoi /100;
    futureValue = fv(expectedRoi/100,investmentDuration, annualInvestment, investedAmount, 0);
    double investedPortion = investedAmount + annualInvestment * investmentDuration;

    interest = futureValue - investedPortion;


   return double.parse(interest.toStringAsFixed(1)) ;

  }

//TODO
  double fv(double r, int nper, double pmt, double pv, int type){

      double fv = (pv * pow(1 + r, nper ) + pmt * (1 + r * type)*(pow(1+r, nper) -1 )/r);
      return fv;
  }



  @override
  void initState(){
    print(' I am in Init Tstae of invest entry');
    this.isSavePressed = false;
    this.statusOfStoring = false;
    this.isTimedOut = false;
   // print(widget.investmentDuration);
    investedAmount = widget.investedAmount;
    expectedRoi = widget.expectedRoi;
    investmentDuration = widget.investmentDuration;
    interestValue = calculateInterset();
    annualInvestment = widget.annualInvestment;
    totalInvestment = investedAmount + widget.annualInvestment;
    super.initState();
    future:Firebase.initializeApp().whenComplete(() {
      fireStore =  FirebaseFirestore.instance;
      investAccess = DRInvestAccess(fireStore, widget.currentUser);
    });

   // print(fireStore.toString());
  }

  Future _update(InvestDB investDB) async {

    DateTime currentPhoneDate = DateTime.now();

    var docID= investDB.investmentId;

        fireStore.collection('pjdhan_investment').doc(investDB.investmentId).update({
        'email': investDB.email,
        'Uuid': investDB.userId,
        'Updated_id': 'system',
        'investment_name': investDB.investment.name,
        'currInvestAmt': investDB.investment.currentInvestmentAmount,
        'annualInvestAmt': investDB.investment.annualInvestmentAmount,
        'investRoI': investDB.investment.investmentRoi,
        'investment_duration': investDB.investment.duration,
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': 'Active',
      }).whenComplete(() {
          setState(() {
            statusOfStoring = true;
            widget.onUpdate!(investDB.investment);


          });

        }).catchError((onError){
          Utility.showErrorMessage(context, onError.toString());

        });



  }

  Future _save(Investment investment) async {



    DateTime currentPhoneDate = DateTime.now();

      await fireStore.collection('pjdhan_investment').add({
        'email': widget.currentUser.email,
        'Uuid': widget.currentUser.uid,
        'Updated_id': 'system',
        'investment_name': investment.name,
        'currInvestAmt': investment.currentInvestmentAmount,
        'annualInvestAmt': investment.annualInvestmentAmount,
        'investRoI': investment.investmentRoi,
        'investment_duration': investment.duration,
        'insert_dts': Timestamp.fromDate(currentPhoneDate),
        'update_dts': Timestamp.fromDate(currentPhoneDate),
        'status': 'Active',
      }).whenComplete(() {
        setState(() {
              statusOfStoring = true;
              Global.investmentCount++;
              widget.onAdd!(Global.investmentCount);

            });

      }).catchError((onError){
          Utility.showErrorMessage(context, e.toString());
          throw onError;
        });

  }




  @override
  Widget build(BuildContext context) {

    interestValue = calculateInterset();
    totalInvestment = investedAmount + annualInvestment*investmentDuration;

     pieData = [

      Task('Investment', totalInvestment, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),
    ];


    return isSavePressed ? WorkDone(isComplete: statusOfStoring,whatToDo:widget.type ,timedOut: isTimedOut,) : Container(
      color: Color(0x00000000),
      child: Wrap(

        children: [
         Container(
           decoration: BoxDecoration(
               color: kPresentTheme.themeColor,
               boxShadow: [
                 BoxShadow(
                   color: kPresentTheme.shadowColor,
                   offset: Offset.zero,
                   blurRadius: 0.5,
                   spreadRadius: 1,

                 )
               ]
           ),
           child: Padding(
             padding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
             child: Container(

               // EditableTextField(
               //   editingController: this.editingController,
               //   initialText:widget.titleMessage, style: DefaultValues.kH2(context),)
               
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Image.asset(widget.imageSource,
                     height: 3.h ,
                     width: 6.w ,) ,
                   Expanded(child: Center(
                       child:Band(
                         onCommit: widget.onEditCommit,
                         onTap: widget.onTap,
                         controller: editingController,
                         text: widget.titleMessage,
                         textStyle: DefaultValues.kH2(context),) ,),),
                   CommandButton(
                     enabled: !this.isEditing,
                     buttonColor: kPresentTheme.alternateColor,
                     //icon: Icons.save,
                     textColor: kPresentTheme.highLightColor,
                     buttonText: widget.type,
                     textSize: 12.sp,
                     onPressed:()  {

                       var inv =  Investment(
                             name: this.editingController.text.compareTo(widget.titleMessage)==0
                                        ?this.editingController.text
                                        :widget.prefix+this.editingController.text,
                             annualInvestmentAmount: annualInvestment,
                             currentInvestmentAmount: investedAmount,
                             duration: investmentDuration,
                             investmentRoi: expectedRoi/100,
                           );



                       setState(()  {
                        if(widget.type == 'Save') {
                          this.isSavePressed = true;
                        Future.any(
                          [
                             _save(inv),
                            Utility.timeoutAfter(sec: 10, onTimeout: (){

                              setState(() {
                                isTimedOut = true;

                              });

                            }),
                          ]
                        );

                        }
                        else{
                          var investDB = InvestDB(
                            email: widget.currentUser.email,
                            userID: widget.currentUser.uid,
                            investmentDocumentID: widget.uniqueId,
                            investment: inv,
                          );


                          this.isSavePressed = true;
                          Future.any(
                              [
                                _update(investDB),
                                Utility.timeoutAfter(sec: 10, onTimeout: (){

                                  setState(() {
                                    isTimedOut = true;

                                  });


                                }),
                              ]
                          );
                        }

                       });

                     }, borderRadius: BorderRadius.circular(10),),
                 ],
               ),
             ),
           ),
         ),


         Row(
           children: [

             Container(
               height: 22.h,
                 width: 48.w,
                 child: DonutChart(pieData: pieData,arcWidth: 20,),),
             Container(
                height: 22.h,
                  width: 48.w,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 3.h,),
                   Row(
                     children: [
                       Container(
                           height: 1.5.h,
                           width: 3.w,
                           color: kPresentTheme.accentColor),
                       Padding(
                         padding: EdgeInsets.only(left : 2.w),
                         child: Text('Total Investment'),
                       ),

                     ],
                   ),
                   Text('${totalInvestment.toStringAsFixed(2)} Lakh',style: DefaultValues.kH3(context),),
                   Row(
                     children: [
                       Container(height: 1.h, width: 2.w ,color: kPresentTheme.alternateColor),
                       Padding(
                         padding:  EdgeInsets.only(left : 2.w),
                         child: Text('Total Interest'),
                       ),

                     ],
                   ),
                   Text('${interestValue} Lakh',style: DefaultValues.kH3(context),),
                   SizedBox(height: 0.6.h,width: double.infinity,),
                   Container(height: 0.3.h,width: double.infinity,color: Colors.black12,),
                   SizedBox(height: 0.2.h,width: double.infinity,),
                   Text('${(totalInvestment+interestValue).toStringAsFixed(2)} Lakh',
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
             perpetualActive: true,
             onChanged: (value){

               setState(() {
                 investedAmount = value;
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

             sliderValue: investedAmount,
             min: 0,
             max: 100,
             labelText: 'Initial Investment',
             suffix: 'Lakhs',
           ),
         ),
          Padding(
            padding: EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              perpetualActive: true,
              onChanged: (value){

                setState(() {
                  annualInvestment = value;
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
              sliderValue: annualInvestment,
              min: 0,
              max: 10,
              labelText: 'Annual Investment',
              suffix: 'Lakhs',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              implementWarning: true,
              threshold: 20,
              onChanged: (value){
                setState(() {
                  expectedRoi = value;
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
              labelText: 'Expected return per year',
              sliderValue: expectedRoi,
              suffix: '%      ',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:2.w, right: 2.w),
            child: LabeledSlider(
              activeColor: kPresentTheme.accentColor,
              onChanged: (value){
                setState(() {
                  investmentDuration = value.round();
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
              labelText: 'Time Period',
              sliderValue: investmentDuration.toDouble(),
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




