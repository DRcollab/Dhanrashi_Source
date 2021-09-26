import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/buttons.dart';
import 'components/constants.dart';
import 'components/dounut_charts.dart';
import 'components/labeled_slider.dart';
import 'package:sizer/sizer.dart';

class SIPCalculator extends StatefulWidget {
 // const SIPCalculator({Key? key}) : super(key: key);




  @override
  _SIPCalculatorState createState() => _SIPCalculatorState();
}

class _SIPCalculatorState extends State<SIPCalculator> {

  List<Task> pieData = [];
  double investedAmount = 1;
  double interestValue = 0 ;
  double totalInvestment = 1;
  int selectedValue = 0;
  int investmentDuration = 1;
  double annualInvestment = 1;
  double expectedRoi=1;


  @override
  Widget build(BuildContext context) {

    pieData = [

      Task('Investment', investedAmount, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),


    ];

    return CustomScaffold(
        child:ListView(
          children: [
            Stack(

              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPresentTheme.themeColor,//Color(0x00000000),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset.zero,
                            blurRadius: 0.5,
                            spreadRadius: 1,

                          ),

                        ]
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(2.w),
                      child: Center(child: Text('SIP Calculator', style: DefaultValues.kH1(context),)),
                    ),
                  ),
                ),


                Padding(

                  padding: DefaultValues.kAdaptedTopPadding(context,35),
                  child: Row(
                    children: [

                      Container(
                          height: 24.h,width: 48.w,
                          child: DonutChart(pieData: pieData,)),
                      Container(height: 22.h,width: 44.w,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3.h ,),
                            Row(
                              children: [
                                Container(
                                    height: 1.h, width: 2.w ,color: kPresentTheme.accentColor),
                                Padding(
                                  padding:  EdgeInsets.only(left : 2.w),
                                  child: Text('Total Investment'),
                                ),

                              ],
                            ),
                            Text('${totalInvestment.toStringAsFixed(2)} Lakh',style: DefaultValues.kH3(context),),
                            Row(
                              children: [
                                Container(height: 1.h, width: 2.w ,color: kPresentTheme.alternateColor),
                                Padding(
                                  padding: const EdgeInsets.only(left : 8.0),
                                  child: Text('Total Interest'),
                                ),

                              ],
                            ),
                            Text('${interestValue} Lakh',style: DefaultValues.kH3(context),),
                            SizedBox(height: 0.5.h,width: double.infinity,),
                            Container(height: 0.2.h,width: double.infinity,color: Colors.black12,),
                            SizedBox(height: 0.5.h,width: double.infinity,),
                            Text('${(totalInvestment+interestValue).toStringAsFixed(2)} Lakh',
                              style: DefaultValues.kH1(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding:DefaultValues.kAdaptedTopPadding(context, 210),
                  child: Card(

                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: selectedValue,
                                onChanged: (value){}
                            ),
                            Text('I know my Investment amount ', style: DefaultValues.kNormal2(context),),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:3.h),
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (value){}
                              ),
                              Text('I know my Required amount ',style: DefaultValues.kNormal2(context)),
                            ],
                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ],
            ),


            Padding(
              padding:  EdgeInsets.only(left:2.w, right: 2.w),
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
              padding: EdgeInsets.only(left:2.w, right: 2.w),
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
              padding: EdgeInsets.only(left:2.w, right: 2.w),
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
              padding: EdgeInsets.only(left:2.w, right: 2.w),
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

            // Padding(
            //   padding: const EdgeInsets.only(left:8.0, right: 8.0),
            //   child: LabeledSlider(
            //     onChanged: (value){
            //       setState(() {
            //         investmentDuration = value.round();
            //       });
            //
            //     },
            //
            //
            //     validator: (value){
            //
            //     },
            //     min: 1,
            //     max: 30,
            //     labelText: 'Time Period',
            //     sliderValue: investmentDuration.toDouble(),
            //     textPrecision: 0,
            //     textEditable: false,
            //     suffix: 'Years',
            //   ),
            // ),
          ],


        ) ,

    );
  }
}
