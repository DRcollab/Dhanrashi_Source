import 'dart:math';
import 'dart:async';
import 'package:dhanrashi_mvp/components/maps.dart';
import 'package:dhanrashi_mvp/components/vanish_keyboard.dart';
import 'package:dhanrashi_mvp/screens/dashboard.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/components/work_done.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/empty_page_inputs.dart';
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

import 'labelled_input.dart';

// double investedAmount = 10;
// double expectedRoi = 23;
// int investmentDuration = 8;

class InvestmentSheet extends StatefulWidget {
  // const ActionSheet({Key? key}) : super(key: key);

  late String titleMessage;
  late String
      prefix; // used to determine the type of investment when user has changed the name of the investment
  double investedAmount = 0;
  double expectedRoi = 0;
  int investmentDuration = 0;
  double annualInvestment = 0;
  String imageSource = '';
  // late void Function(dynamic) save;
  String display = '';
  String? uniqueId;
  String type;
  late var currentUser;
  Function(Investment? inv)? onUpdate;
  Function(dynamic)? onAdd;
  late Function()? onTap;
  late Function() onEditCommit;
  String roiHintMessage = '';
  // final String? Function(String?) validator => return 0;

  InvestmentSheet({
    this.titleMessage = '',
    required this.investedAmount,
    required this.expectedRoi,
    required this.investmentDuration,
    this.imageSource = '',
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
    this.roiHintMessage = '',
  });

  @override
  _InvestmentSheetState createState() => _InvestmentSheetState();
}

class _InvestmentSheetState extends State<InvestmentSheet> {
  //var seriesPieData =  <charts.Series<Task, String>>[];

  bool textBoxLostFocus = false;
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
  double interestValue =
      0; // holds calculated value of futureValue of the investment
  double annualInvestment = 1;
  // Investment currentInvestment = Investment();
  late FirebaseFirestore fireStore;
  bool text1Active = false;
  bool text2Active = false;

  double totalInvestment = 0.0;
  int whichTextController = 0;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController currentInvestmentController = TextEditingController();
  TextEditingController annualInvestmentController = TextEditingController();
  TextEditingController dummy = TextEditingController();
  double calculateInterset() {
    double interest;
    // double roi = expectedRoi /100;
    futureValue = fv(expectedRoi / 100, investmentDuration, annualInvestment,
        investedAmount, 0);
    double investedPortion =
        investedAmount + annualInvestment * investmentDuration;

    interest = futureValue - investedPortion;

    return double.parse(interest.toStringAsFixed(1));
  }

//TODO
  double fv(double r, int nper, double pmt, double pv, int type) {
    double fv = (pv * pow(1 + r, nper) +
        pmt * (1 + r * type) * (pow(1 + r, nper) - 1) / r);
    return fv;
  }


  @override
  void dispose() {
    // TODO: implement dispose


    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) =>
    //         Dashboard(currentUser: widget.currentUser,)));

    super.dispose();
  }

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }


  @override
  void initState() {
    //  titleEditingController = TextEditingController(text:widget.titleMessage);
    this.isSavePressed = false;
    this.statusOfStoring = false;
    this.isTimedOut = false;

    investedAmount = widget.investedAmount;
    expectedRoi = widget.expectedRoi;
    investmentDuration = widget.investmentDuration;
    interestValue = calculateInterset();
    annualInvestment = widget.annualInvestment;
    totalInvestment = investedAmount + widget.annualInvestment;
    super.initState();
    future:
    Firebase.initializeApp().whenComplete(() {
      fireStore = FirebaseFirestore.instance;
      // investAccess = DRInvestAccess(fireStore, widget.currentUser);
    });
  }









  Future _update(InvestDB investDB) async {
    DateTime currentPhoneDate = DateTime.now();

    var docID = investDB.investmentId;

    fireStore
        .collection('pjdhan_investment')
        .doc(investDB.investmentId)
        .update({
      'email': investDB.email,
      'Uuid': investDB.userId,
      'Updated_id': 'system',
      'investment_name': investDB.investment.name,
      'currInvestAmt': investDB.investment.currentInvestmentAmount,
      'annualInvestAmt': investDB.investment.annualInvestmentAmount,
      'investRoI': investDB.investment.investmentRoi,
      'investment_duration': investDB.investment.duration,
      'update_dts': Timestamp.fromDate(currentPhoneDate),
      'status': widget.type != 'Delete' ? 'Active' : 'InActive',
    }).whenComplete(() {

        setState(() {
          statusOfStoring = true;
          if (widget.type == 'Delete') {
            Global.investmentCount--;
          }
          widget.onUpdate!(investDB.investment);
        });

    }).

    catchError((onError) {
      Utility.showErrorMessage(context, onError.toString() + 'Hello : ');
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
    }).catchError((onError) {
      Utility.showErrorMessage(context, e.toString());
      throw onError;
    });
  }

  @override
  Widget build(BuildContext context) {
    double corpusValue = 0;
    interestValue = calculateInterset();
    totalInvestment = investedAmount + annualInvestment * investmentDuration;
    corpusValue = totalInvestment + interestValue;
    //
    if (corpusValue > DefaultValues.threshold) {}

    pieData = [
      Task('Investment', totalInvestment, kPresentTheme.accentColor),
      Task('Interest Earned', interestValue, kPresentTheme.alternateColor),
    ];

    return isSavePressed
        ? WorkDone(
            isComplete: statusOfStoring,
            whatToAdd: 'Investment "${widget.titleMessage}"',
            whatToDo: widget.type,
            timedOut: isTimedOut,
          )
        : VanishKeyBoard(
            onTap: () {
              String text = '';
              setState(() {
                isEditing = false;

                switch (whichTextController) {
                  case 1:
                    if (dummy.text.contains('₹')) {
                      text = dummy.text.substring(1).replaceAll(',', '').trim();
                      investedAmount = double.parse(dummy.text);
                    } else {
                      if(dummy.text!='') investedAmount = double.parse(dummy.text);
                    }

                    text1Active =
                        false; // determines whether textBox1 in the context recieved a tap and now it is released.
                    dummy.text =
                        DefaultValues.textFormat.format(investedAmount);
                    break;
                  case 2:
                    if (dummy.text.contains('₹')) {
                      text = dummy.text.substring(1).replaceAll(',', '').trim();
                      annualInvestment = double.parse(dummy.text);
                    } else {
                      if(dummy.text!='') {
                        print('Blank found');
                        annualInvestment = double.parse(dummy.text);

                      }
                    }

                    text2Active =
                        false; // determines whether textBox2 in the context recieved a tap and now it is released.
                    if(dummy.text!='') {
                      dummy.text = DefaultValues.textFormat
                          .format(double.parse(dummy.text));
                    }else{
                      dummy.text = DefaultValues.textFormat
                          .format(double.parse('0'));
                    }
                    break;
                  default:
                    print('Expected ROI $expectedRoi');
                    break;
                }
              });
            },
            child: Container(
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
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Container(
                        // EditableTextField(
                        //   editingController: this.editingController,
                        //   initialText:widget.titleMessage, style: DefaultValues.kH2(context),)

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              widget.imageSource,
                              height: 3.h,
                              width: 6.w,
                            ),
                            Expanded(
                              child: (widget.type != 'Delete')
                                  ? Band(
                                      onCommit: () {
                                        widget.onEditCommit();
                                        textBoxLostFocus = true;
                                      },
                                      onTap: widget.onTap,
                                      controller: titleEditingController,
                                      text: widget.titleMessage,
                                      textStyle: DefaultValues.kH2(context),
                                    )
                                  : Card(
                                      child: Text(
                                      widget.titleMessage,
                                      style: DefaultValues.kH2(context),
                                    )),
                            ),
                            CommandButton(
                              enabled: !this.isEditing,
                              buttonColor: (widget.type != 'Delete')
                                  ? kPresentTheme.alternateColor
                                  : Colors.red,
                              //icon: Icons.save,
                              textColor: kPresentTheme.highLightColor,
                              buttonText: widget.type,
                              textSize: 12.sp,
                              onPressed: () {
                                var inv = Investment(
                                  name: investmentIcons.containsKey(this
                                          .titleEditingController
                                          .text
                                          .trim())
                                      ? this.titleEditingController.text
                                      : widget.prefix +
                                          this.titleEditingController.text,
                                  annualInvestmentAmount: annualInvestment,
                                  currentInvestmentAmount: investedAmount,
                                  duration: investmentDuration,
                                  investmentRoi: expectedRoi / 100,
                                );

                                setState(() {
                                  if (widget.type == 'Save') {
                                    this.isSavePressed = true;
                                    Future.any([
                                      _save(inv),
                                      Utility.timeoutAfter(
                                          sec: 10,
                                          onTimeout: () {
                                            setState(() {
                                              isTimedOut = true;
                                            });
                                          }),
                                    ]);
                                  } else {
                                    var investDB = InvestDB(
                                      email: widget.currentUser.email,
                                      userID: widget.currentUser.uid,
                                      investmentDocumentID: widget.uniqueId,
                                      investment: inv,
                                    );

                                    this.isSavePressed = true;
                                    Future.any([
                                      _update(investDB),
                                      Utility.timeoutAfter(
                                          sec: 10,
                                          onTimeout: () {
                                            setState(() {
                                              isTimedOut = true;
                                            });
                                          }),
                                    ]);
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.type == 'Delete'
                      ? Utility.showBanner(
                          context,
                          'You are about to delete this investment. This action is irreversible.',
                          Colors.red.shade50,
                          Colors.red)
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Row(
                    children: [
                      Container(
                        height: 22.h,
                        width: 48.w,
                        child: DonutChart(
                          pieData: pieData,
                          arcWidth: 20,
                        ),
                      ),
                      Container(
                        height: 22.h,
                        width: 48.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 1.5.h,
                                    width: 3.w,
                                    color: kPresentTheme.accentColor),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Text('Total Investment',
                                      textScaleFactor:
                                          DefaultValues.screenHeight(context) <
                                                  600
                                              ? 0.7
                                              : 1),
                                ),
                              ],
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  corpusValue < DefaultValues.threshold
                                      ? '${DefaultValues.textFormat.format(totalInvestment)}'
                                      : '${DefaultValues.textShortFormat.format(totalInvestment)}',
                                  style: DefaultValues.kH3(context),
                                )),
                            Row(
                              children: [
                                Container(
                                    height: 1.5.h,
                                    width: 3.w,
                                    color: kPresentTheme.alternateColor),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Text('Total Interest',
                                      textScaleFactor:
                                          DefaultValues.screenHeight(context) <
                                                  600
                                              ? 0.7
                                              : 1),
                                ),
                              ],
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  corpusValue > 0
                                      ? (corpusValue < DefaultValues.threshold
                                          ? '${DefaultValues.textFormat.format(interestValue)}'
                                          : '${DefaultValues.textShortFormat.format(interestValue)}')
                                      : 0.toString(),
                                  style: DefaultValues.kH3(context),
                                )),
                            SizedBox(
                              height: 0.6.h,
                              width: double.infinity,
                            ),
                            Container(
                              height: 0.3.h,
                              width: double.infinity,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 0.2.h,
                              width: double.infinity,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                corpusValue > 0
                                    ? (corpusValue < DefaultValues.threshold
                                        ? '${DefaultValues.textFormat.format(corpusValue)}'
                                        : '${DefaultValues.textShortFormat.format(corpusValue)}')
                                    : 0.toString(),
                                style: DefaultValues.kH2(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: LabeledInput(
                      mute: (widget.type ==
                          'Delete'), // Checks if this widget is used for deletion or not. In case it is for delete then LabeledInput will
                      // stay muted;
                      controller: currentInvestmentController,
                      initialValue: investedAmount,
                      label: DefaultValues.titles['inv_start_title']!,
                      icon: Icon(Icons.bar_chart),

                      validator: () {
                        setState(() {
                          whichTextController = 1;
                          isEditing = true;
                          text1Active = true;
                          dummy = currentInvestmentController;
                          if (text2Active) {
                            annualInvestment =
                                double.parse(annualInvestmentController.text);
                            annualInvestmentController.text =
                                DefaultValues.textFormat.format(double.parse(
                                    annualInvestmentController.text));
                            text2Active = false;
                          }
                        });
                      },
                      onCompleteEditing: () {
                        String text;
                        setState(() {
                          isEditing = false;
                          text1Active = false;
                          text2Active = false;
                          if (currentInvestmentController.text.contains('₹')) {
                            text = currentInvestmentController.text
                                .substring(1)
                                .replaceAll(',', '')
                                .trim();
                            investedAmount = double.parse(text);
                          } else {
                            investedAmount =
                                double.parse(currentInvestmentController.text);
                          }

                          // dummy.text =DefaultValues.textFormat.format(double.parse(dummy.text));
                          currentInvestmentController.text =
                              DefaultValues.textFormat.format(double.parse(
                                  currentInvestmentController.text));
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: LabeledInput(
                      mute: (widget.type ==
                          'Delete'), // Checks if this widget is used for deletion or not. In case it is for delete then LabeledInput will
                      // stay muted;
                      controller: annualInvestmentController,
                      initialValue: annualInvestment,
                      // controller: editingController,
                      label: DefaultValues.titles['inv_rec_title']!,
                      icon: Icon(
                        Icons.show_chart,
                        color: Colors.amber,
                      ),

                      // getValue: (value){
                      //     annualInvestment = double.parse(value.toString());
                      // },
                      validator: () {
                        setState(() {
                          whichTextController = 2;
                          dummy = annualInvestmentController;
                          isEditing = true;
                          text2Active = true;
                          if (text1Active) {
                            investedAmount =
                                double.parse(currentInvestmentController.text);
                            currentInvestmentController.text =
                                DefaultValues.textFormat.format(double.parse(
                                    currentInvestmentController.text));
                            text1Active = false;
                          }
                        });
                      },
                      onCompleteEditing: () {
                        String text = '';
                        setState(() {
                          if (annualInvestmentController.text.contains('₹')) {
                            text = annualInvestmentController.text
                                .substring(1)
                                .replaceAll(',', '')
                                .trim();
                            annualInvestment = double.parse(text);
                          } else {
                            annualInvestment =
                                double.parse(annualInvestmentController.text);
                          }
                          annualInvestmentController.text =
                              DefaultValues.textFormat.format(double.parse(
                                  annualInvestmentController.text));
                          isEditing = false;
                          text2Active = false;
                          text1Active = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: (widget.type != 'Delete')
                        ? LabeledSlider(
                            activeColor: kPresentTheme.accentColor,
                            // implementWarning: true,
                            // threshold: 20,
                            onChanged: (value) {
                              setState(() {
                                expectedRoi = value;

                              });
                            },

                            validator: () {
                              setState(() {
                                isEditing = true;
                                whichTextController = 3;
                              });
                            },
                            onEditingComplete: () {

                              setState(() {
                                isEditing = false;
                              });
                            },
                            min: DefaultValues.minReturn,
                            max: 30,
                           // divisions: 30,
                            labelText: 'Expected return per year',
                            suggestiveIcon: Tooltip(
                              message: widget.roiHintMessage,
                              child: Icon(Icons.info),
                            ),
                            textPrecision: 2,
                            sliderValue: expectedRoi,
                            suffix: '%      ',
                          )
                        : LabeledInput(
                            controller: TextEditingController(),
                            mute: true,
                            label: 'Expected return per year',
                            initialValue: investmentDuration.toDouble(),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: (widget.type != 'Delete')
                        ? LabeledSlider(
                            activeColor: kPresentTheme.accentColor,
                            onChanged: (value) {
                              setState(() {
                                investmentDuration = value.round();
                              });
                            },
                            validator: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                            min: 1,
                            max: DefaultValues.maxSlideYear,
                            //divisions: 30,
                            labelText: 'Time Period',
                            sliderValue: investmentDuration.toDouble(),
                            textPrecision: 0,
                            textEditable: false,
                            suffix: 'Years',
                          )
                        : LabeledInput(
                            controller: TextEditingController(),
                            mute: true,
                            label: DefaultValues.titles['inv_time_title']!,
                            initialValue: investmentDuration.toDouble(),
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}
