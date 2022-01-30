import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:dhanrashi_mvp/sip_calculator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import 'components/constants.dart';
//import 'components/tile_class.dart';
import 'package:sizer/sizer.dart';
import 'components/investment_entry_sheet.dart';
import 'models/user_data_class.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';



class InvestmentInputScreen extends StatefulWidget {
  //const InvestmentInputScreen({Key? key}) : super(key: key);

  var currentUser;

  InvestmentInputScreen({required this.currentUser});

  @override
  _InvestmentInputScreenState createState() => _InvestmentInputScreenState();
}

class _InvestmentInputScreenState extends State<InvestmentInputScreen> {
  Color color = kPresentTheme.accentColor;

  Color alternateColor = kPresentTheme.alternateColor;

  Color titleColor = Colors.black;

  int investmentCount = 0;

  String name = '';

  double currentInvestmentAmount = 0;

  double annualInvestmentAmount = 0;

  double investmentRoi = 0;

  double investmentDuration = 0;

  int _currentTabIndex = 1 ;

  late bool moveKB = false;

  late FirebaseFirestore fireStore;

  GlobalKey _showCaseKey1 = GlobalKey();
  GlobalKey _showCaseKey2 = GlobalKey();



  @override
  void initState() {
    // TODO: implement initState
    investmentCount = Global.investmentCount;

    super.initState();
    moveKB = false;


  }





  @override
  Widget build(BuildContext context) {

    return ShowCaseWidget(
      builder: Builder(
          builder: (context) {
            return CustomScaffold(
              currentUser: widget.currentUser,
              helper: (){
                print('Hello ');
                ShowCaseWidget.of(context)!.startShowCase([_showCaseKey1,_showCaseKey2]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:0.0),
                          child: Image.asset('images/investment_banner.png',
                            height: 19.h,
                            width: 100.w,
                            fit: BoxFit.fitHeight,
                            //alignment: Alignment.topLeft,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(
                            left: 5.w,
                            top: 18.h,
                          ),
                          child: ListTile(
                            title: Text("Investments: " ,
                              style:DefaultValues.kH1(context),

                            ),
                            trailing: investmentCount>0 ? Showcase(
                              shapeBorder: CircleBorder(),
                              contentPadding: EdgeInsets.all(10),
                              overlayPadding: EdgeInsets.all(20),
                              key: _showCaseKey1,
                              description: 'Get the number of Investments saved',
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(currentUser: widget.currentUser,tabNumber: 2,),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: kPresentTheme.accentColor,
                                  radius: 20,
                                  child:Text(investmentCount.toString(), style: DefaultValues.kH3(context),),


                                ),
                              ),
                            ):SizedBox(),
                            subtitle: Text(DefaultValues.messages['inv_choice']!,
                              style:DefaultValues.kNormal3(context),
                            ),
                          ),

                        ),

                      ],
                    ),
                  ),

                  Container(height: 15,width:double.infinity),
                  Expanded(
                    flex:5,
                    child: Showcase(
                      key: _showCaseKey2,

                      description: 'Click these tiles to enter your investments',
                      child: Container(
                        // height: 20.h,
                        child:GridView.count(
                          shrinkWrap: false,

                          crossAxisCount: 2,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/mutual.png',

                                    title: DefaultValues.titles['mf']!,
                                    title2: 'Fund',
                                    subText: DefaultValues.titles['mf_st']!,
                                    color: kPresentTheme.accentColor,
                                    titleColor: Colors.white60,
                                    onPressed: (){
                                      name = 'Mutual Fund';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                roiHintMessage:  'Last 5 years Debt funds grew at ${Global.stockReturn * 100}%\n,Equity fund grew at ${Global.stockReturn * 100}%\n& Balanced Fund grew at ${Global.stockReturn * 100}%',
                                                prefix: '#',
                                                currentUser: widget.currentUser,
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
                                                titleMessage: name,

                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                expectedRoi: Global.mfReturn *100,
                                                annualInvestment: 0,
                                                imageSource: 'images/mutual.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },

                                  ),
                                ),

                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/stock.png',
                                    //  height: 120,
                                    //  width: 150,
                                    title: DefaultValues.titles['equity']!,
                                    subText: DefaultValues.titles['equity_st']!,
                                    color: alternateColor,
                                    titleColor: titleColor,
                                    onPressed: (){
                                      name = 'Equity';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                roiHintMessage: 'For last 5 years Nifty grew at ${Global.stockReturn * 100} %',
                                                prefix: '%',
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
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.stockReturn * 100,
                                                imageSource: 'images/stock.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),

                              ],
                            ),// Row 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/bank.png',
                                    //  height: 120,
                                    //  width: 150,
                                    title: DefaultValues.titles['fd']!,
                                    subText: DefaultValues.titles['fd_st']!,
                                    color: alternateColor,
                                    titleColor: titleColor,
                                    onPressed: (){
                                      name = 'Bank FD';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: '^',
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
                                                roiHintMessage: 'Presently banks are giving FD interest @ ${Global.fdReturn*100} %',
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.fdReturn * 100,
                                                imageSource: 'images/bank.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },

                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),


                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/real-estate.png',
                                    // height: 120,
                                    // width: 150,
                                    title: DefaultValues.titles['real']!,
                                    subText: DefaultValues.titles['real_st']!,
                                    color:color,
                                    titleColor: Colors.white60,
                                    onPressed: (){
                                      name = 'Real Estate';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: '&',
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
                                                roiHintMessage: 'Real Estate values are growing  @ ${Global.realEstateReturn*100} %',
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.realEstateReturn * 100,
                                                imageSource: 'images/real-estate.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/coin.png',
                                    //    height: 120,
                                    //   width: 150,
                                    title: DefaultValues.titles['gold']!,
                                    subText: DefaultValues.titles['gold_st']!,
                                    color:color,
                                    titleColor: Colors.white60,
                                    onPressed: (){
                                      name = 'Gold';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: '*',
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
                                                roiHintMessage: 'Gold valuation grew @ ${Global.goldReturn*100} % for last 5 years' ,
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.goldReturn * 100,
                                                imageSource: 'images/coin.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),

                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/insurance.png',

                                    title: DefaultValues.titles['insurance']!,
                                    subText: DefaultValues.titles['insurance_st']!,
                                    color: kPresentTheme.alternateColor,
                                    titleColor: titleColor,
                                    onPressed: (){
                                      name = 'Insurance';
                                      print('click on $name');
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: '@',
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
                                                roiHintMessage: 'Presently insurance are giving  interest @ ${Global.fdReturn*100} %',
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.avgReturn * 100,
                                                imageSource: 'images/insurance.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),

                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/bonds.png',
                                    // height: 120,
                                    // width: 150,
                                    title: DefaultValues.titles['bonds']!,
                                    subText: DefaultValues.titles['bonds_st']!,
                                    color: alternateColor,
                                    titleColor: titleColor,
                                    onPressed: (){
                                      name = 'Bonds';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: ':',
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
                                                roiHintMessage: 'Bond return for last 2 years is @ ${Global.bondYield*100} %',
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.bondYield * 100,
                                                imageSource: 'images/bonds.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Tile(
                                    imageSource: 'images/products.png',
                                    //    height: 120,
                                    //    width: 150,
                                    title: DefaultValues.titles['others_inv']!,
                                    subText: DefaultValues.titles['others_st']!,
                                    color: color,
                                    titleColor: Colors.white60,
                                    onPressed: (){
                                      name = 'Other';

                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => SingleChildScrollView(
                                            child: Container(
                                              padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                                  :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                              child: InvestmentSheet(
                                                prefix: '!',
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
                                                roiHintMessage: 'Presently banks are giving FD interest @ ${Global.fdReturn*100} %',
                                                currentUser: widget.currentUser,
                                                titleMessage: name,
                                                investedAmount: 0,
                                                investmentDuration: DefaultValues.investmentDuration,
                                                annualInvestment: 0,
                                                expectedRoi: Global.avgReturn * 100,
                                                imageSource: 'images/products.png',
                                                onAdd: (value){
                                                  setState(() {
                                                    investmentCount = value;
                                                  });
                                                },

                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),

                              ],
                            )


                          ],

                        ),
                      ),
                    ),
                  ),



                ],
              ),
              // body: Container(color: Colors.red,
              //           width: double.infinity,
              //     height: 10,
              // ) ,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedFontSize:  DefaultValues.screenHeight(context)<600? 8:12,
                currentIndex: _currentTabIndex,
                onTap: (index){
                  setState(() {
                    _currentTabIndex = index;
                  });

                  switch(index){

                    case 0:
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalsInputScreen(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                    case 2:
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                    case 3:


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SIPCalculator(currentUser: widget.currentUser,),
                        ),
                      );
                      break;
                  }

                },
                items: DefaultValues.bottomTabs,


              ),
            );
          }
      ),
    );
  }
}


