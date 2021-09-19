
import 'dart:math';

import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
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

// double investedAmount = 10;
// double expectedRoi = 23;
// int investmentDuration = 8;


class InvestmentSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  late String titleMessage;
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
  // final String? Function(String?) validator => return 0;

  InvestmentSheet({
    this.titleMessage='',
    required this.investedAmount,
    required this.expectedRoi,
    required this.investmentDuration,
    this.imageSource='',
    this.annualInvestment = 0,
  //  required this.save,
    required this.currentUser,
    this.uniqueId,
    this.type = 'Save',
  });

  @override
  _InvestmentSheetState createState() => _InvestmentSheetState();
}

class _InvestmentSheetState extends State<InvestmentSheet> {

  //var seriesPieData =  <charts.Series<Task, String>>[];
  List<Task> pieData = [];

  //String display = '';
  double sliderValue = 5;
  double futureValue = 0;
  double investedAmount = 1;
  double expectedRoi = 1;
  int investmentDuration = 1;
  double interestValue = 0 ;        // holds calculated value of futureValue of the investment
  double annualInvestment = 0;
 // Investment currentInvestment = Investment();
  late FirebaseFirestore fireStore;
  late var investAccess;
  double totalInvestment = 0.0;

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

  void _update(InvestDB investDB) async {
    try{
      await investAccess.updateInvestmentSolo(investDB,'Active');
    }
    catch(e){
      Utility.showErrorMessage(context, e.toString());
    }


  }

  void _save(Investment investment) async {
    final snackBar = SnackBar(
      content: Text(' Your investments are saved successfully'),
    );
    print(fireStore.toString());


    try{
      await investAccess.storeInvestmentSolo(investment);
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




  @override
  Widget build(BuildContext context) {

    //print(fireStore.toString());
    interestValue = calculateInterset();
    totalInvestment = investedAmount + annualInvestment;

  //  print('PV : $investedAmount and IV:$interestValue');

     pieData = [

      Task('Investment', investedAmount, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),


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
                   Image.asset(widget.imageSource, height: 30, width: 30,),
                   Expanded(child: Center(child: Text(widget.titleMessage, style: DefaultValues.kH1(context),))),
                   CommandButton(
                     buttonColor: kPresentTheme.alternateColor,
                     //icon: Icons.save,
                     textColor: kPresentTheme.highLightColor,
                     buttonText: widget.type,
                     onPressed:()  {
                      print(' To Be saved .......:');
                       print('email: ${widget.currentUser.email}');
                       print('uid : ${widget.currentUser.uid}');
                       print(widget.titleMessage);
                       print('Annual Inv : ${annualInvestment}');
                       print('current Inv: ${investedAmount}');
                       print('duration: ${investmentDuration}');
                       print('ROI : ${interestValue}');


                       var inv =  Investment(
                             name:widget.titleMessage,
                             annualInvestmentAmount: annualInvestment,
                             currentInvestmentAmount: investedAmount,
                             duration: investmentDuration,
                             investmentRoi: expectedRoi/100,
                           );

                       print('.... printing inv:;;;;;;;;');
                       print(inv);

                       setState(() {
                        if(widget.type == 'Save') {
                          _save(inv);
                        }
                        else{
                          var investDB = InvestDB(
                            email: widget.currentUser.email,
                            userID: widget.currentUser.uid,
                            investmentDocumentID: widget.uniqueId,
                            investment: inv,
                          );
                          _update(investDB);
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
               height: 180,width: 180,
                 child: DonutChart(pieData: pieData,)),
             Container(height: 180,width: 180,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 30,),
                   Row(
                     children: [
                       Container(
                           height: 10, width: 12 ,color: kPresentTheme.accentColor),
                       Padding(
                         padding: const EdgeInsets.only(left : 8.0),
                         child: Text('Total Investment'),
                       ),

                     ],
                   ),
                   Text('${totalInvestment.toStringAsFixed(2)} Lakh',style: DefaultValues.kH3(context),),
                   Row(
                     children: [
                       Container(height: 10, width: 12 ,color: kPresentTheme.alternateColor),
                       Padding(
                         padding: const EdgeInsets.only(left : 8.0),
                         child: Text('Total Interest'),
                       ),

                     ],
                   ),
                   Text('${interestValue} Lakh',style: DefaultValues.kH3(context),),
                   SizedBox(height: 5,width: double.infinity,),
                   Container(height: 2,width: double.infinity,color: Colors.black12,),
                   SizedBox(height: 5,width: double.infinity,),
                   Text('${(totalInvestment+interestValue).toStringAsFixed(2)} Lakh',
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
                 investedAmount = value;
               });

             },

             validator: (value){

                },
             sliderValue: investedAmount,
             min: 1,
             max: 100,
             labelText: 'Invested Amount',
             suffix: 'Lakhs',
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){

                setState(() {
                  annualInvestment = value;
                });

              },

              validator: (value){

              },
              sliderValue: annualInvestment,
              min: 0,
              max: 100,
              labelText: 'Annual Investment',
              suffix: 'Lakhs',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  expectedRoi = value;
                });

              },

              validator: (value){

              },
              min: 1,
              max:30,
              labelText: 'Expected return per year',
              sliderValue: expectedRoi,
              suffix: '%      ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: LabeledSlider(
              onChanged: (value){
                setState(() {
                  investmentDuration = value.round();
                });

              },


              validator: (value){

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




