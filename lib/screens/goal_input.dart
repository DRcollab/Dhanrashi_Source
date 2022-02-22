import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:dhanrashi_mvp/screens/sip_calculator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import '../components/constants.dart';

import '../components/goal_entry_sheet.dart';
import 'dashboard.dart';
import 'investmentinput.dart';

import 'package:sizer/sizer.dart';


//<a href="https://storyset.com/work">Work illustrations by Storyset</a>



class GoalsInputScreen extends StatefulWidget {


  var currentUser;



GoalsInputScreen({required this.currentUser});

  @override
  _GoalsInputScreenState createState() => _GoalsInputScreenState();
}

class _GoalsInputScreenState extends State<GoalsInputScreen> {
  Color color = kPresentTheme.accentColor;

  Color alternateColor = kPresentTheme.alternateColor;

  Color titleColor = Colors.black;

  //var investment = Investment();
  int goalCount = 0;
  String name = '';

  double currentInvestmentAmount = 0;

  double annualInvestmentAmount = 0;

  double investmentRoi = 0;

  double investmentDuration = 0;
  int _currentTabIndex = 0;
  late FirebaseFirestore fireStore;
  bool moveKB = false;

  GlobalKey _showCaseKey1 = GlobalKey();
  GlobalKey _showCaseKey2 = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    goalCount = Global.goalCount;

    super.initState();

    
  }




  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return CustomScaffold(
            currentUser: widget.currentUser,
            helper: (){
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
                        padding: EdgeInsets.only(left:10.w),
                        child: Image.asset('images/goals.png',
                                        height: 21.h,
                                        width: 100.w,
                                        alignment: Alignment.topLeft),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                                      left: 5.w,
                                      top: 18.h,
                              ),
                        child: ListTile(
                          title: Text("Goals",
                            style:DefaultValues.kH1(context),

                          ),
                          trailing: goalCount>0 ?Showcase(
                            key: _showCaseKey1,
                            description: 'Get the number of Goals saved',
                            shapeBorder: CircleBorder(),
                            overlayPadding: EdgeInsets.all(20),
                            contentPadding: EdgeInsets.all(10),

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(currentUser: widget.currentUser,tabNumber: 1,),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: kPresentTheme.accentColor,
                                radius: 20,
                                child: Text(goalCount.toString(), style: DefaultValues.kH3(context),),
                              ),
                            ),
                          ):SizedBox(),
                          subtitle: Text(DefaultValues.messages['goal_choice']!,
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
                    description: 'Click these tiles to enter your goals',
                    child: Container(

                      child:GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: false,
                        childAspectRatio: 1.2,
                        children: [

                          Tile(
                            imageSource: 'images/car.png',
                            //height: 120,
                            //width: 150,
                              title: DefaultValues.titles['car']!,
                            subText: DefaultValues.titles['car_st']!,
                            color: color,
                            titleColor: Colors.white60,
                            onPressed: (){
                              name = 'My Dream Car';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                      :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
                                        prefix: '#',
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
                                       // roiHintMessage: 'Presently banks are giving FD interest @ ${Global.fdReturn*100} %',
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 0,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.carInflation * 100,
                                        imageSource: 'images/car.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;


                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },

                          ),

                          Tile(
                            imageSource: 'images/house.png',
                            //height: 20,
                            //width: 150,
                            title: DefaultValues.titles['house']!,
                            subText: DefaultValues.titles['house_st']!,
                            color: alternateColor,
                            titleColor: titleColor,
                            onPressed: (){
                              name = 'My Dream House';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 0,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.houseInflation * 100,
                                        imageSource: 'images/house.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },
                          ),// Row 1
                          Tile(
                            imageSource: 'images/education.png',
                            // height: 120,
                            // width: 150,
                            title: DefaultValues.titles['education']!,
                            subText: DefaultValues.titles['education_st']!,
                            color: alternateColor,
                            titleColor: titleColor,
                            onPressed: (){
                              name = 'Child Education';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.educationInflation * 100,
                                        imageSource: 'images/education.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },
                          ),

                          Tile(
                            imageSource: 'images/pension.png',
                            //  height: 120,
                            //  width: 150,
                            title: DefaultValues.titles['retirement']!,
                            subText: DefaultValues.titles['retirement_st']!,
                            color: color,
                            titleColor: Colors.white60,
                            onPressed: (){
                              name = 'Retirement';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.retailInflation * 100,
                                        imageSource: 'images/pension.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },
                          ),
                          Tile(
                            imageSource: 'images/tour.png',
                            // height: 250,
                            // width: 150,
                            title: DefaultValues.titles['travel']!,
                            subText: DefaultValues.titles['travel_st']!,
                            color:color,
                            titleColor: Colors.white60,
                            onPressed: (){
                              name = 'Travel';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.tourInflation*100,
                                        imageSource: 'images/tour.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },
                          ),

                          Tile(
                            imageSource: 'images/destination.png',
                             // height: 120,
                            //  width: 150,
                            title: DefaultValues.titles['family']!,
                            subText: DefaultValues.titles['family_st']!,
                            color: alternateColor,
                            titleColor: titleColor,
                            onPressed: (){
                              name = 'Family Events';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.retailInflation * 100,
                                        imageSource: 'images/destination.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },

                                      ),
                                    ),
                                  ));
                            },
                          ),

                          Tile(
                            imageSource: 'images/healthcare.png',
                            //    height: 120,
                            //   width: 150,
                            title: DefaultValues.titles['health']!,
                            subText: DefaultValues.titles['health_st']!,
                            color:alternateColor,
                            titleColor: titleColor,
                            onPressed: (){
                              name = 'Health';

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                                          :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
                                      child: GoalSheet(
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

                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.healthInflation * 100,
                                        imageSource: 'images/healthcare.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ));
                            },
                          ),

                          Tile(
                            imageSource: 'images/products.png',
                            //    height: 120,
                            //    width: 150,
                            title: DefaultValues.titles['others']!,
                            subText: DefaultValues.titles['others_gol_st']!,
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
                                      child: GoalSheet(
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
                                        currentUser: widget.currentUser,
                                        titleMessage: name,
                                        goalAmount: 10,
                                        goalDuration: DefaultValues.goalDuration,
                                        inflation: Global.retailInflation * 100,
                                        imageSource: 'images/products.png',
                                        onAdd: (value){
                                          setState(() {
                                            goalCount = value;
                                          });
                                        },

                                      ),
                                    ),
                                  ));
                            },
                          )


                        ],

                      ),
                    ),
                  ),
                ),
              ],
            ),
            selectedBottomNavtab: 0,
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   currentIndex: _currentTabIndex,
            //   onTap: (index){
            //     setState(() {
            //        _currentTabIndex = index;
            //     });
            //
            //     switch(index){
            //
            //       case 1:
            //         Navigator.pop(context);
            //
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => InvestmentInputScreen(currentUser: widget.currentUser,),
            //           ),
            //         );
            //         break;
            //       case 2:
            //         Navigator.pop(context);
            //
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Dashboard(currentUser: widget.currentUser,),
            //           ),
            //         );
            //
            //         break;
            //       case 3:
            //
            //
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => SIPCalculator(currentUser: widget.currentUser,),
            //           ),
            //         );
            //         break;
            //     }
            //   },
            //
            //   items: DefaultValues.bottomTabs,
            // ),
          );
        }
      ),
    );
  }
}


