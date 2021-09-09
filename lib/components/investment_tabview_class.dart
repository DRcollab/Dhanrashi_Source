import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import '../investmentinput.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';

import 'maps.dart';

class InvestmentTabView extends StatelessWidget {
   //InvestmentTabView({Key? key}) : super(key: key);

  InvestmentTabView({required this.investments, required this.currentUser, this.totalInvest=0});

  late List<InvestDB> investments;
  late var currentUser;
  double totalInvest;
  final   pieData = [

    Task('Investment', 10, kPresentTheme.accentColor),
    Task('Interest Earned', 18 ,kPresentTheme.alternateColor),


  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            width: 150,
            child: DonutChart(pieData: pieData
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
                    leadingImage: investmentIcons[this.investments[index].investment.name],
                    title:  investments[index].investment.name,
                    subtitle: investments[index].investment.currentInvestmentAmount.toString(),
                    value:investments[index].investment.duration.toString()
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
