

import 'package:dhanrashi_mvp/components/analytics_tabview.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart';
import 'package:dhanrashi_mvp/components/goal_tabview_class.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/main.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'data/financial_calculator.dart';
import 'data/goal_access.dart';
import 'empty_page_inputs.dart';
import 'investmentinput.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'components/investment_tabview_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/goal_db.dart';
import 'models/investment.dart';
import 'models/investment_db.dart';

class Dashboard extends StatefulWidget {

  var currentUser;



  Dashboard({required this.currentUser});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late FirebaseFirestore fireStore;
  late var goalAccess;
  List<GoalDB> goals = [];
  List<InvestDB> investments=[];
  double totalGoalValue = 0.0;
  double totalInvestValue = 0.0;
  int longestInvestmentDuration = 0;
  int longestGoalDuration = 0;
  bool isGoalEmpty = false;
  bool isInvestmentEmpty = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(' ------------- &&&&&&& Hi ai am gerr ');
    //future:Firebase.initializeApp().then((value) => null)
    future:Firebase.initializeApp().then((value) {
      fireStore =  FirebaseFirestore.instance;

        fetchGoals();
        fetchInvestment();


     // goalAccess = DRGoalAccess(fireStore, widget.currentUser);
    }).onError((error, stackTrace){
      print( ' THer it is :   ${error.toString()}');
    }

    );
  }

  Future fetchGoals() async{

    fireStore.collection('pjdhan_goal').where('Uuid', isEqualTo: widget.currentUser.uid)
        .get()
        .then((QuerySnapshot snapshot){
      if( snapshot.docs.isEmpty){
        // setState(() {
        //   isGoalEmpty = snapshot.docs.isEmpty;
        // });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmptyPage(currentUser: widget.currentUser,)));
      }

      snapshot.docs.forEach((f) {
        String email=f.get('email');
        String userID=f.get('Uuid');
        String docID=f.id;
        print('docid : $docID');
        String goalName=f.get('goal_name');
        String goalDescription=f.get('goal_description');
        double amount=f.get('goal_amount');
        double inflation = f.get('inflation');
        totalGoalValue = totalGoalValue+amount;
        int duration=f.get('goal_duration');
        if(duration > longestGoalDuration){
          longestGoalDuration = duration;
        }
        //double inflation = f.get('inflation');
       setState(() {

          goals.add(
              GoalDB(
                email:email,
                goalDocumentID:docID,
                user:userID,
                goal: Goal(
                  name:goalName,
                  description: goalDescription,
                  goalAmount: amount,
                  duration: duration,
                  inflation: inflation,
                ),
              )
          );
       });

      });
     //  print('is Goal Empty : $isGoalEmpty');
      //return  goals;
    }
    );
  }


  Future fetchInvestment() async{

    fireStore.collection('pjdhan_investment').where('Uuid', isEqualTo: widget.currentUser.uid)
        .get()
        .then((QuerySnapshot snapshot){
      if(snapshot.docs.isEmpty){
        // setState(() {
        //   isInvestmentEmpty = snapshot.docs.isEmpty;
        // });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmptyPage(currentUser: widget.currentUser,)));

      }

      snapshot.docs.forEach((f) {
        String email=f.get('email');
        String userID=f.get('Uuid');
        String docID= f.id;
        print('docid inv: $docID');
        String investmentName=f.get('investment_name');
        double currInvestAmt=f.get('currInvestAmt');
        totalInvestValue = totalInvestValue + currInvestAmt;
        double annualInvestAmt=f.get('annualInvestAmt');
        double investRoI=f.get('investRoI');
        int duration=f.get('investment_duration');
        if(duration > longestInvestmentDuration){
          longestInvestmentDuration = duration;
        }

       setState(() {

          investments.add(
              InvestDB(
                email:email,
                investmentDocumentID: docID,
                userID: userID,
                investment: Investment(
                  name: investmentName,
                  currentInvestmentAmount: currInvestAmt,
                  annualInvestmentAmount: annualInvestAmt,
                  investmentRoi: investRoI,
                  duration: duration,
                ) ,
              )
          );
       });

      //  print('is Inv empty : $isInvestmentEmpty');
      });
     // return listInvest;
    }
    );
  }



  @override
  Widget build(BuildContext context) {



    return DefaultTabController(
          length: 3,
          child: CustomScaffold(
            currentUser: this.widget.currentUser,
              title: 'Dashboard',
              child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Material(

                  child: TabBar(

                    indicator: RectangularIndicator(
                      //height: 5,
                      topLeftRadius: 15,
                      topRightRadius: 15,
                      bottomLeftRadius: 15,
                      bottomRightRadius: 15,
                      horizontalPadding: 10,
                      verticalPadding: 7,

                      //tabPosition: TabPosition,
                      paintingStyle: PaintingStyle.fill,
                      strokeWidth: 10,
                    ),
                    indicatorColor: kPresentTheme.accentColor,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text:'Analytics'),
                      Tab(text:'Goals'),
                      Tab(text: 'Investments',),

                    ],

            ),
                ),
              ),
            body: TabBarView(
              children: [
               // AnalyticsTabView(),
                AnalyticsTabView(
                  goalDBs:goals,
                  currentUser: widget.currentUser,
                  investmentDBs: investments,
                  longestGoalDuration: longestGoalDuration,
                  longestInvestmentDuration: longestInvestmentDuration,
                ),

                GoalsTabView(
                  goalDBs:goals,
                  currentUser: widget.currentUser,
                  totalAmount: totalGoalValue,
                  longestInvestmentDuration: longestInvestmentDuration,
                  longestGoalDuration: longestGoalDuration,
                ),// 2nd view
                InvestmentTabView(
                  investmentDBs: investments,
                  currentUser: widget.currentUser,
                  totalInvest: totalInvestValue,
                  longestInvestmentDuration: longestInvestmentDuration,
                  longestGoalDuration: longestGoalDuration,

                ),

              ]
            ),
          ),

    );

  }
}
