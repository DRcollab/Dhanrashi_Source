import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
//import 'components/tile_class.dart';
import 'data/investment_class.dart';
import 'components/action_screen.dart';





class InvestmentInputScreen extends StatelessWidget {
  //const InvestmentInputScreen({Key? key}) : super(key: key);

  Color color = kPresentTheme.accentButtonColor;
  Color alternateColor = kPresentTheme.navigationColor;
  Color titleColor = Colors.black;

  var investment = Investment.create();

  String name;
  double currentInvestmentAmount;
  double annualInvestmentAmount;
  double investmentRoi;
  double investmentDuration;






  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      child: Container(

        child: ListView(

             // crossAxisAlignment: CrossAxisAlignment.stretch,
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:0.0),
                        child: Image.asset('images/investment_banner.png', height: 400, width: 400,alignment: Alignment.topLeft),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0,top: 140.0),
                        child: Text("Investments",
                          style: kH1,

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0,top: 170.0),
                        child: Text("Choose one of  these",
                          style: kH3,

                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top:190),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Tile(
                                      imageSource: 'images/mutual.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Mutual Fund',
                                      subText: 'Equity and debt funds',
                                      color: color,
                                      titleColor: Colors.white60,
                                      onPressed: (){
                                        name = 'Mutual Fund';
                                        showModalBottomSheet(context: context, builder: (context) => ActionSheet(
                                          titleMessage: name,
                                        ));
                                      },

                                    ),
                                  ),

                                  Expanded(
                                    child: Tile(
                                      imageSource: 'images/insurance.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Insurance',
                                      subText: 'Life, health and term',
                                      color: alternateColor,
                                      titleColor: titleColor,
                                      onPressed: (){
                                        name = 'Insurance';
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
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Debts & Bonds',
                                      subText: 'Govt Bonds company debentures',
                                      color: alternateColor,
                                      titleColor: titleColor,
                                      onPressed: (){
                                        name = 'Debts and Bonds';
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    child: Tile(
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Equity',
                                      subText: 'Stock market investments',
                                      color: color,
                                      titleColor: Colors.white60,
                                      onPressed: (){
                                        name = 'Equity';
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
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Real Estate',
                                      subText: 'Lands, houses, complexes etc.',
                                      color:color,
                                      titleColor: Colors.white60,
                                      onPressed: (){
                                        name = 'Real Estate';
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    child: Tile(
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Bank FD',
                                      subText: 'NSC, KVP, RD, Bank term deposits',
                                      color: alternateColor,
                                      titleColor: titleColor,
                                      onPressed: (){
                                        name = 'Bank FD';
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
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Gold',
                                      subText: 'Jewellery ',
                                      color:alternateColor,
                                      titleColor: titleColor,
                                      onPressed: (){
                                        name = 'Gold';
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    child: Tile(
                                      imageSource: 'images/info.png',
                                      height: 120,
                                      width: 150,
                                      title: 'Others',
                                      subText: 'Something not listed here',
                                      color: color,
                                      titleColor: Colors.white60,
                                      onPressed: (){
                                        name = 'Other';
                                      },
                                    ),
                                  ),

                                ],
                              )

                            ],
                          ),
                        ),
                      )
                    ],
                  ),



                // Image.asset('images/investing-pana.png', height: 200, width: 200,),

              ],
        ),
      ),
    );
  }
}


