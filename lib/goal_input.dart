import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:dhanrashi_mvp/sip_calculator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import 'components/constants.dart';

import 'components/goal_entry_sheet.dart';
import 'dashboard.dart';

import 'inv_grid.dart';
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
    print('000000wwwwww');
    print(Global.goalCount);

    super.initState();
   // future:Firebase.initializeApp().whenComplete(() =>fireStore =  FirebaseFirestore.instance );
    
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
                          subtitle: Text(Messages.goalChoiceHeader,
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

                      child:ListView(
                        shrinkWrap: false,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Tile(
                                  imageSource: 'images/car.png',
                                  //height: 120,
                                  //width: 150,
                                    title: 'My Dream\nCar',
                                  subText: 'Buy my very own car\n',
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
                                              currentUser: widget.currentUser,
                                              titleMessage: name,
                                              goalAmount: 10,
                                              goalDuration: 10,
                                              inflation: 4.5,
                                              imageSource: 'images/car.png',
                                              onAdd: (value){
                                                setState(() {
                                                  goalCount = value;
                                                  print('Goal count');
                                                  print(value);

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
                                  imageSource: 'images/house.png',
                                  //height: 20,
                                  //width: 150,
                                  title: 'My Dream\nHouse',
                                  subText: 'My sweet home\n',
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
                                              goalAmount: 5,
                                              goalDuration: 20,
                                              inflation: 6,
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
                                ),
                              ),

                            ],
                          ),// Row 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Tile(
                                  imageSource: 'images/education.png',
                                  // height: 120,
                                  // width: 150,
                                  title: 'Child\nEducation',
                                  subText: 'Education empowers life\n',
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
                                              goalDuration: 10,
                                              inflation: 6,
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
                              ),

                              Expanded(
                                child: Tile(
                                  imageSource: 'images/pension.png',
                                  //  height: 120,
                                  //  width: 150,
                                  title: 'Retirement',
                                  subText: 'A blissful life\n',
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
                                              goalDuration: 5,
                                              inflation: 15,
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
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Tile(
                                  imageSource: 'images/tour.png',
                                  // height: 250,
                                  // width: 150,
                                  title: 'Travel',
                                  subText: "Tours and travels\n",
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
                                              goalDuration: 20,
                                              inflation: 12,
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
                              ),

                              Expanded(
                                child: Tile(
                                  imageSource: 'images/destination.png',
                                   // height: 120,
                                  //  width: 150,
                                  title: 'Family \nEvents',
                                  subText: 'Moments of Togetherness',
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
                                              goalDuration: 5,
                                              inflation: 5,
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
                              ),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Tile(
                                  imageSource: 'images/healthcare.png',
                                  //    height: 120,
                                  //   width: 150,
                                  title: 'Health',
                                  subText: 'Health related expenses\n',
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
                                              goalDuration: 10,
                                              inflation: 10,
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
                              ),

                              Expanded(
                                child: Tile(
                                  imageSource: 'images/products.png',
                                  //    height: 120,
                                  //    width: 150,
                                  title: 'Others',
                                  subText: 'Anything not listed here\n',
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
                                              goalDuration: 10,
                                              inflation: 12,
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

            bottomNavigationBar: BottomNavigationBar(
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
                        builder: (context) => InvestmentInputScreen(currentUser: widget.currentUser,),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(currentUser: widget.currentUser,),
                      ),
                    );

                    break;
                  case 2:


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SIPCalculator(currentUser: widget.currentUser,),
                      ),
                    );
                    break;
                }
              },

              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.chartLine,size: 15.sp,),
                  label: 'Investment',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.chartPie,color: kPresentTheme.accentColor,size: 15.sp,),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.calculator,size: 15.sp,color: Colors.orange,),
                  label: 'SIP Calculator',
                )
              ],
            ),
          );
        }
      ),
    );
  }
}


