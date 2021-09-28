import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/chart_view.dart';
import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_gifs/loading_gifs.dart';
import '../investmentinput.dart';
import 'buttons.dart';
import 'dounut_charts.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/data/financial_calculator.dart';
import 'package:sizer/sizer.dart';
import 'maps.dart';

class InvestmentTabView extends StatefulWidget {
   //InvestmentTabView({Key? key}) : super(key: key);

  InvestmentTabView({
    required this.investmentDBs,
    required this.currentUser,
    this.totalInvest=0,
    this.longestGoalDuration = 0,
    this.longestInvestmentDuration = 0,

  });

  late FirebaseFirestore fireStore;
  int longestGoalDuration;
  int longestInvestmentDuration;
  late List<InvestDB> investmentDBs;
  late var currentUser;
  double totalInvest;

  @override
  _InvestmentTabViewState createState() => _InvestmentTabViewState();
}

class _InvestmentTabViewState extends State<InvestmentTabView> {

  bool fetched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //
    investments = List.empty(growable: true);
    if(widget.investmentDBs.length>0){
      widget.investmentDBs.forEach((element) {
        investments.add(element.investment);
      });
      dataSet = Calculator().getInvestmentDetail(investments, widget.longestInvestmentDuration, widget.longestGoalDuration);
      fetched = true;
    }


  }



  late List<Investment> investments = [];

  List dataSet = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {




  print(dataSet);
    return Column(
      children: [
        Flexible(
          flex:2,
          child: Container(
              height: 20.h,
              width: 100.w,
              child: fetched ? Stack(
                children: [

                  DynamicGraph(
                    chartType: ChartType.bar,
                    resultSet: dataSet,
                    gallopYears: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              ChartView(
                                chartChild: DynamicGraph(
                                  isVertical: false,
                                  chartType: ChartType.bar,
                                  resultSet: dataSet,
                                  gallopYears: 1,
                                ),

                              )));
                    },
                    child: Container(
                      color: Color(0x00000000),
                      height: 20.h,
                      width: 100.w,
                    ),
                  ),

                ],
              ) : Image.asset(circularProgressIndicator, scale: 3),
          ),
        ),
       Flexible(
         flex:1,
         child: ListTile(
           title:  Text('Total Investment Amount: ${widget.totalInvest.toStringAsFixed(2)}',style: DefaultValues.kNormal3(context)),
           trailing: RoundButton(
               icon:Icons.add,
               onPress:(){
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => InvestmentInputScreen(currentUser: widget.currentUser,)));
               }
           ),

         ),
       ),
        Container(
          height: 50.h,//* DefaultValues.adaptByValue(context,0.50) ,
          child: ListView.builder(
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(left:2.w,right: 2.w),
                child: Shingle(

                    type: 'investment',
                    maxHeight: 11.5.h,
                    updateKey: widget.investmentDBs[index].investmentId,
                    leadingImage: investmentIcons[this.investments[index].name],
                    barColor:DefaultValues.graphColors[index%15],
                    title:  investments[index].name,
                    subtitle: 'Intial investment :${investments[index].currentInvestmentAmount.toString()} \nAnnual Investment:${investments[index].annualInvestmentAmount}',
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
                                  uniqueId: widget.investmentDBs[index].investmentId,
                                  currentUser: this.widget.currentUser,
                                  titleMessage: investments[index].name,
                                  investedAmount: investments[index].currentInvestmentAmount,
                                  annualInvestment: investments[index].annualInvestmentAmount,
                                  investmentDuration: investments[index].duration,
                                  expectedRoi: investments[index].investmentRoi * 100,
                                  imageSource: 'images/destination.png',
                                  type: 'Update',
                                  onUpdate: (newInv){
                                    print('new inv amount');
                                    setState(() {
                                      investments[index] = newInv;
                                    });
                                    print('${investments[index].annualInvestmentAmount}, ${investments[index].currentInvestmentAmount}');
                                  },
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
