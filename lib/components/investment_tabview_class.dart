import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import '../investmentinput.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';

import 'maps.dart';

class InvestmentTabView extends StatelessWidget {
   //InvestmentTabView({Key? key}) : super(key: key);

  InvestmentTabView({required this.investmentDBs, required this.currentUser, this.totalInvest=0, this.longestGoalDuration = 0, this.longestInvestmentDuration = 0});

  int longestGoalDuration;
  int longestInvestmentDuration;
  late List<InvestDB> investmentDBs;
  late var currentUser;
  double totalInvest;
  late List<Investment> investments = [];
  List dataSet = List.empty(growable: true);
  final   pieData = [

    Task('Investment', 10, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),


  ];

  @override
  Widget build(BuildContext context) {

    //
    investmentDBs.forEach((element) {
      investments.add(element.investment);
    });

   dataSet = Calculator().getInvestmentDetail(investments, longestInvestmentDuration, longestGoalDuration);
  print(dataSet);
    return Column(
      children: [
        Container(
            height: 150,
            width: 450,
            child: DynamicGraph(
              chartType: ChartType.bar,
              resultSet: dataSet,
            )
        ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Text('Total Investment Amount: ${totalInvest}'),
           FloatingActionButton(
              backgroundColor: kPresentTheme.accentColor,
               child: Icon(Icons.add),
               mini: true,
               onPressed:(){
             Navigator.push(context,
                 MaterialPageRoute(builder: (context) => InvestmentInputScreen(currentUser: currentUser,)));
           }
           )
         ],
       ),
        Container(
          height: 400,
          child: ListView.builder(
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Shingle(
                    leadingImage: investmentIcons[this.investments[index].name],
                    title:  investments[index].name,
                    subtitle: investments[index].currentInvestmentAmount.toString(),
                    value:investments[index].duration.toString()
                ),
              );

            },
            itemCount: investments.length,

          ),
        ),

      ],
    );
  }
}
