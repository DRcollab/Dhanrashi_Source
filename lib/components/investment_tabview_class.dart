import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/chart_tab_view.dart';
import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:dhanrashi_mvp/data/show_graph_dynamic.dart';
import 'package:dhanrashi_mvp/individual_view.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:showcaseview/showcaseview.dart';
import '../chart_viewer.dart';
import '../empty_page_inputs.dart';
import '../investmentinput.dart';
import 'buttons.dart';
import 'package:dhanrashi_mvp/components/dounut_charts.dart' as donut;
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
    this.showCaseKey,
  });

  late FirebaseFirestore fireStore;
  int longestGoalDuration;
  int longestInvestmentDuration;
  late List<InvestDB> investmentDBs;
  late var currentUser;
  double totalInvest;
  List<GlobalKey?>? showCaseKey;
  @override
  _InvestmentTabViewState createState() => _InvestmentTabViewState();
}

class _InvestmentTabViewState extends State<InvestmentTabView> {

  bool fetched = false;
  bool moveKB = false;
   late List<donut.Task> pieData;
  late List<donut.Task> futurePieData;
  double totalInvest = 0;
  String prefix = '';
  double totalCorpus = 0;
  late List<Investment> investments = [];

  List dataSet = List.empty(growable: true);
  //double futureValue

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalInvest = widget.totalInvest;
    totalCorpus = 0;
    //
    investments = List.empty(growable: true);
    if(widget.investmentDBs.length>0){
      widget.investmentDBs.forEach((element) {
        investments.add(element.investment);
      });
      dataSet = Calculator().getInvestmentDetail(investments, widget.longestInvestmentDuration, widget.longestGoalDuration);
      fetched = true;
    }

    investments.forEach((element) {
      double futureValue = Calculator.fv(element.investmentRoi,
          element.duration,
          element.annualInvestmentAmount,
          element.currentInvestmentAmount, 0);

      totalCorpus = futureValue + totalCorpus;

    });

  }


  _edit(int index , String type){

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding:!moveKB ?EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
            :EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
            child: InvestmentSheet(
              prefix: this.prefix,
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
              uniqueId: widget.investmentDBs[index].investmentId,
              currentUser: this.widget.currentUser,
              titleMessage: '#@:%&^*!'.contains(investments[index].name.substring(0,1))
                  ?investments[index].name.substring(1)
                  :investments[index].name,
              investedAmount: investments[index].currentInvestmentAmount,
              annualInvestment: investments[index].annualInvestmentAmount,
              investmentDuration: investments[index].duration,
              expectedRoi: investments[index].investmentRoi * 100,
              imageSource: investmentIcons.containsKey(this.investments[index].name)
                  ?investmentIcons[this.investments[index].name]
                  :investmentIcons[this.investments[index].name.substring(0,1)],
              type: type,
              onUpdate: (newInv){

                setState(() {
                  if(type!='Delete'){
                    investments[index] = newInv!;
                    widget.investmentDBs[index].investment = investments[index];
                  }else{
                    investments.removeAt(index);
                    widget.investmentDBs.removeAt(index);
                  }

                  totalInvest = 0;
                  totalCorpus = 0;
                  if(investments.isNotEmpty) {
                    investments.forEach((element) {
                      totalInvest = element.currentInvestmentAmount + element.annualInvestmentAmount * element.duration +totalInvest;
                      double futureValue = Calculator.fv(element.investmentRoi, element.duration,element.annualInvestmentAmount,
                          element.currentInvestmentAmount, 0);

                      totalCorpus = futureValue + totalCorpus;
                    });



                    int lngstInv = Calculator().getLongestInvestmentDuration(
                        investments);
                    dataSet.clear();
                    dataSet = Calculator().getInvestmentDetail(
                        investments, lngstInv, widget.longestGoalDuration);
                  } else{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EmptyPage(currentUser: widget.currentUser,)));
                  }
                });

              },
            ),
          ),
        ));
  }


  _showThisData(int index, double fv){



    Navigator.push(context,
    MaterialPageRoute(builder: (context) =>
        IndividualInvestment(
            currentUser: widget.currentUser,
            data: [dataSet[index]],
            pieData: [
                      donut.Task('Total Investment', totalInvest, kPresentTheme.accentColor),
                      donut.Task('This Investment', investments[index].currentInvestmentAmount +
                          investments[index].annualInvestmentAmount* investments[index].duration,
                          kPresentTheme.alternateColor),
              ],
          futurePieData:[
            donut.Task('Projected Future total  Corpus', this.totalCorpus, kPresentTheme.accentColor),
            donut.Task('Projected corpus',fv ,
                kPresentTheme.alternateColor),
          ]
          ),

    ),
    );

  }
    @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Flexible(
          flex:2,
          child: Showcase(
            key: widget.showCaseKey![0],
            title: 'Chart view of your Investments',
            description: 'Click here view tabular form',

            child: Container(

                child: fetched ? Stack(
                  children: [

                   investments.isNotEmpty ? DynamicGraph(
                      chartType: ChartType.bar,
                      resultSet: dataSet,
                      gallopYears: widget.longestInvestmentDuration~/5,
                    ): SizedBox(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ChartViewer(
                                  currentUser : widget.currentUser,
                                  dataSet: dataSet,
                                )));
                                // ChartView(

                      },
                      child: Container(
                        color: Color(0x00000000),
                        height: 20.h,
                        width: 100.w,
                      ),
                    ),

                  ],
                ) : Image.asset(kPresentTheme.progressIndicator, scale: 3),
            ),
          ),
        ),
       Flexible(
         flex:1,
         child: ListTile(
           title:  Text('Total Corpus: ${
              totalInvest<DefaultValues.threshold ? DefaultValues.textFormat.format(totalCorpus)
               :DefaultValues.textShortFormat.format(totalCorpus)}',
               style: DefaultValues.kH3(context)),
           trailing: Showcase(
             key: widget.showCaseKey![1],
             description:'Click here to add a new investment',
             child: RoundButton(
                 icon:Icons.add,
                 onPress:(){
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => InvestmentInputScreen(currentUser: widget.currentUser,)));
                 }
             ),
           ),

         ),
       ),
        Container(
          height: 50.h,//* DefaultValues.adaptByValue(context,0.50) ,
          child: ListView.builder(
            itemBuilder: (context, index){

             // double futureValue = Calculator.fv(r, nper, pmt, pv, type)
              double futureValue = Calculator.fv(investments[index].investmentRoi,
                  investments[index].duration, 
                  investments[index].annualInvestmentAmount, 
                  investments[index].currentInvestmentAmount, 0);

                  totalCorpus = futureValue + totalCorpus;





              return Padding(
                padding: EdgeInsets.only(left:2.w,right: 2.w),
                child: Showcase(
                  key: index==0 ? widget.showCaseKey![2]:new GlobalKey(),
                  description:'Click here to view and update the investment',

                  child: Shingle(
                      onPressed:(){
                        if('#@:%&^*!'.contains(investments[index].name.substring(0,1))){
                          prefix=investments[index].name.substring(0,1);

                        }else{
                          prefix=symbols[investments[index].name.trim()];
                        }
                        _edit(index,'Update');
                        //_showThisData(index, futureValue);
                      },
                      hasExtraText: true,
                      type: 'investment',
                      maxHeight: 17.h,
                      updateKey: widget.investmentDBs[index].investmentId,
                      leadingImage: investmentIcons.containsKey(this.investments[index].name)
                          ?investmentIcons[this.investments[index].name]
                          :investmentIcons[this.investments[index].name.substring(0,1)],
                      barColor:DefaultValues.graphColors[index%15],
                      title:'#@:%&^*!'.contains(investments[index].name.substring(0,1))
                            ?investments[index].name.substring(1)
                            :investments[index].name,
                      prefix: '#@:%&^*!'.contains(investments[index].name.substring(0,1))
                              ?investments[index].name.substring(0,1)
                              :'',
                    //${Utility.changeToPeriodicDecimal(investments[index].currentInvestmentAmount).toString()} ${Utility.getPeriod(investments[index].currentInvestmentAmount)}
                      subtitle: 'Initial:${
                         futureValue<DefaultValues.threshold ?DefaultValues.textFormatWithDecimal.format(investments[index].currentInvestmentAmount)
                      :DefaultValues.textShortFormat.format(investments[index].currentInvestmentAmount)  }',

                      text:'Annual: ${
                          futureValue<DefaultValues.threshold ? DefaultValues.textFormatWithDecimal.format(  investments[index].annualInvestmentAmount)
                              :DefaultValues.textShortFormat.format(investments[index].annualInvestmentAmount)
                      } ',
                      value:' ${investments[index].duration.toString()} Yrs' ,
                      text2: '${(investments[index].investmentRoi*100).toStringAsFixed(2)}%',
                      icon1: Icons.watch_later_outlined,
                      icon2: FontAwesomeIcons.chartLine,
                      highlight:'Corpus: ${
                          futureValue<DefaultValues.threshold ? DefaultValues.textFormat.format(futureValue)
                          :DefaultValues.textShortFormat.format(futureValue)
                      }' ,
                      trailing: Showcase(
                        key: index==0 ? widget.showCaseKey![3]:new GlobalKey(),
                        description: 'Click here to delete the investment',
                        child: IconButton(
                          icon: Icon(Icons.delete, size: 16.sp,) ,
                          onPressed: (){

                            _edit(index,'Delete');
                          },


                        ),
                      ),
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




