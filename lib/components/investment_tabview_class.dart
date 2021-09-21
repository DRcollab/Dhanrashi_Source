import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
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

    bool fetched = false;
    //
    investments = List.empty(growable: true);
    if(investmentDBs.length>0){
      investmentDBs.forEach((element) {
        investments.add(element.investment);
      });
      dataSet = Calculator().getInvestmentDetail(investments, longestInvestmentDuration, longestGoalDuration);
      fetched = true;
    }



  print(dataSet);
    return Column(
      children: [
        Container(
            height: 150,
            width: 450,
            child: fetched ? DynamicGraph(
              chartType: ChartType.bar,
              resultSet: dataSet,
            ) : Image.asset(circularProgressIndicator, scale: 10),
        ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Text('Total Investment Amount: ${totalInvest.toStringAsFixed(2)}'),
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
          height: 400* DefaultValues.adaptByValue(context,0.50) ,
          child: ListView.builder(
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Shingle(
                    leadingImage: investmentIcons[this.investments[index].name],
                    title:  investments[index].name,
                    subtitle: 'Intial investment :${investments[index].currentInvestmentAmount.toString()} \nAnnual Investment:${investments[index].annualInvestmentAmount * 12}',
                    value:'Investment Duration: ${investments[index].duration.toString()} \nExpected ROI:${(investments[index].investmentRoi*100).toStringAsFixed(2)}%',
                    trailing: IconButton(
                      icon: Icon(Icons.edit) ,
                      onPressed: (){
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: InvestmentSheet(
                                  uniqueId: investmentDBs[index].investmentId,
                                  currentUser: this.currentUser,
                                  titleMessage: investments[index].name,
                                  investedAmount: investments[index].currentInvestmentAmount,
                                  annualInvestment: investments[index].annualInvestmentAmount,
                                  investmentDuration: investments[index].duration,
                                  expectedRoi: investments[index].investmentRoi * 100,
                                  imageSource: 'images/destination.png',
                                  type: 'Update',
                                ),
                              ),
                            ));
                      },


                    ),
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
