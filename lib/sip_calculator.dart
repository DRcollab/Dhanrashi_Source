import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/buttons.dart';
import 'components/constants.dart';
import 'components/dounut_charts.dart';
import 'components/labeled_slider.dart';
import 'package:sizer/sizer.dart';

import 'components/labelled_input.dart';
import 'components/menu_drawer_class.dart';
import 'data/financial_calculator.dart';

class SIPCalculator extends StatefulWidget {

  var currentUser;
SIPCalculator({this.currentUser});



  @override
  _SIPCalculatorState createState() => _SIPCalculatorState();
}

class _SIPCalculatorState extends State<SIPCalculator> {

  List<Task> pieData = [];
  bool isEditing=false;
  double investedAmount = 1;
  double interestValue = 0 ;
  double totalInvestment = 1;
  int selectedValue = 0;
  int investmentDuration = 1;
  double annualInvestment = 1;
  double expectedRoi=1;
  final  _sipKey = GlobalKey<ScaffoldState>();
  double goalAmount = 0;
  double sipAmount = 0;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController currentInvestmentController = TextEditingController();
  TextEditingController annualInvestmentController = TextEditingController();
  TextEditingController dummy = TextEditingController();

  bool text1Active = false;
  bool text2Active = false;
  late var investAccess;

  int whichTextController = 0;

  @override
  initState(){

    super.initState();

  }


  double calculateInterset( ){



    double interest;
    // double roi = expectedRoi /100;
    double futureValue = Calculator.fv(expectedRoi/100,investmentDuration, annualInvestment, investedAmount, 0);
    double investedPortion = investedAmount + annualInvestment * investmentDuration;

    interest = futureValue - investedPortion;

    return double.parse(interest.toStringAsFixed(1)) ;

  }



  @override
  Widget build(BuildContext context) {
    //
    // if(selectedValue == 0){
    //   investedAmount = valueSlider1;
    //   annualInvestment = valueSlider2;
    // }else{
    //   investedAmount = valueSlider2;
    //   goalAmount = valueSlider1;
    //   annualInvestment = Calculator.sipAmount(expectedRoi/100, investmentDuration, investedAmount, goalAmount, 0);
    //    sipAmount = annualInvestment * 100000/12;
    // }




    // interestValue = calculateInterset();
    // totalInvestment = investedAmount + annualInvestment*investmentDuration;
    //
    // goalAmount = totalInvestment+interestValue;
    // annualInvestment = Calculator.sipAmount(expectedRoi/100, investmentDuration, investedAmount, goalAmount, 0);
    // sipAmount = annualInvestment * 100000/12;

    pieData = [

      Task('Investment', totalInvestment, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue ,kPresentTheme.alternateColor),


    ];

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: kPresentTheme.themeColor,//Color(0xffb5c210),
        systemNavigationBarIconBrightness: Brightness.dark,
        // systemNavigationBarColor: Colors.black,
      ) ,
      child: Scaffold(
          key: _sipKey,
          body:SafeArea(
            child: ListView(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 20.w,),
                                          Text('SIP Calculator', style: DefaultValues.kH1(context),),
                                      Padding(
                                        padding: EdgeInsets.only(left:18.w),
                                        child: GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },

                                            child: Icon(Icons.close,color: Colors.red,),
                                        ),
                                      ),
                                    ],
                          ),
                        ),
                      ),
                    ),


                    Padding(

                      padding: DefaultValues.kAdaptedTopPadding(context,35),
                      child: Row(
                        children: [

                          Container(

                              height: 20.h,width: 40.w,
                              child: DonutChart(pieData: pieData,arcWidth: 15,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(height: 22.h,width: 44.w,

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
                                  Text('${DefaultValues.textFormatWithDecimal.format(totalInvestment)} Lakh',style: DefaultValues.kH3(context),),
                                  Row(
                                    children: [
                                      Container(height: 1.h, width: 2.w ,color: kPresentTheme.alternateColor),
                                      Padding(
                                        padding: const EdgeInsets.only(left : 8.0),
                                        child: Text('Total Interest'),
                                      ),

                                    ],
                                  ),
                                  Text('${DefaultValues.textFormatWithDecimal.format(interestValue)} Lakh',style: DefaultValues.kH3(context),),
                                  SizedBox(height: 0.5.h,width: double.infinity,),
                                  Container(height: 0.2.h,width: double.infinity,color: Colors.black12,),
                                  SizedBox(height: 0.5.h,width: double.infinity,),
                                  Text(
                                    selectedValue == 0 ?'Your corpus ${investmentDuration} years is'
                                    :'Your monthly SIP',
                                    style: DefaultValues.kH4(context),
                                  ),
                                  Text(
                                    selectedValue == 0 ?'Rs.${(totalInvestment+interestValue).toStringAsFixed(2)} Lakh'
                                    :'Rs.${sipAmount.toStringAsFixed(2)}',

                                    style: DefaultValues.kH1(context),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding:DefaultValues.kAdaptedTopPadding(context, 210),
                      child: Card(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 0,
                                    groupValue: selectedValue,
                                    onChanged: (value){
                                      setState(() {
                                        selectedValue = int.parse( value.toString());
                                        print('Value: $selectedValue');
                                      });
                                    }
                                ),
                                Text('I know my Investment amount ', style: DefaultValues.kNormal2(context),),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: selectedValue,
                                    onChanged: (value){
                                      setState(() {
                                        selectedValue = int.parse( value.toString());
                                        print('Value: $selectedValue');
                                      });

                                    }
                                ),
                                Text('I know my Required amount ',style: DefaultValues.kNormal2(context)),
                              ],
                            )


                          ],
                        ),
                      ),
                    ),
                  ],
                ),

        LabeledInput(
          // Checks if this widget is used for deletion or not. In case it is for delete then LabeledInput will
          // stay muted;
          controller: currentInvestmentController,
          initialValue: investedAmount,
          label: selectedValue == 0 ? 'Initial Investment':'Goal Amount',
          icon: Icon(Icons.bar_chart),
          // getValue: (value){
          //
          //   investedAmount = double.parse(value.toString());
          // },

          validator: (){
            setState(() {
              whichTextController = 1;
              isEditing = true;
              text1Active = true;
              dummy = currentInvestmentController;
              if(text2Active) {
                annualInvestment =
                    double.parse(annualInvestmentController.text);
                annualInvestmentController.text =
                    DefaultValues.textFormat.format(double.parse(
                        annualInvestmentController.text));
                text2Active = false;
              }
            });
          },
          onCompleteEditing: (){
            setState(() {
              isEditing = false;
              text1Active = false;
              text2Active = false;
              investedAmount = double.parse(currentInvestmentController.text);

              currentInvestmentController.text = DefaultValues.textFormat.format(double.parse( currentInvestmentController.text));

            });
          },

//selectedValue == 0 ? 'Annual Investment':'Initial Investment',
        ),
                LabeledInput(

                  controller: annualInvestmentController,
                  initialValue: annualInvestment,
                  // controller: editingController,
                  label: selectedValue == 0 ? 'Annual Investment':'Initial Investment',
                  icon:Icon(Icons.show_chart, color: Colors.amber,),

                  // getValue: (value){
                  //     annualInvestment = double.parse(value.toString());
                  // },
                  validator: (){
                    setState(() {
                      whichTextController = 2;
                      dummy = annualInvestmentController;
                      isEditing = true;
                      text2Active = true;
                      if(text1Active) {
                        investedAmount =
                            double.parse(currentInvestmentController.text);
                        currentInvestmentController.text =
                            DefaultValues.textFormat.format(double.parse(
                                currentInvestmentController.text));
                        text1Active = false;
                      }
                    });
                  },
                  onCompleteEditing: (){

                    setState(() {
                      annualInvestment = double.parse(annualInvestmentController.text);

                      annualInvestmentController.text = DefaultValues.textFormat.format(double.parse( annualInvestmentController.text));
                      isEditing = false;
                      text2Active = false;
                      text1Active = false;

                    });
                  },

                ),


                Padding(
                  padding: EdgeInsets.only(left:2.w, right: 2.w),
                  child: LabeledSlider(
                    activeColor: kPresentTheme.accentColor,
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
                    min: 0,
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


            ),
          ) ,
        drawer: MenuDrawer(currentUser: widget.currentUser, ),
      ),
    );
  }
}
