import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:dhanrashi_mvp/dashboard.dart';
import 'package:dhanrashi_mvp/data/investment_access.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/goal_input.dart';
import 'package:dhanrashi_mvp/models/investment_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/constants.dart';
//import 'components/tile_class.dart';

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



  String name = '';

  double currentInvestmentAmount = 0;

  double annualInvestmentAmount = 0;

  double investmentRoi = 0;

  double investmentDuration = 0;

  int _currentTabIndex = 0 ;

  late FirebaseFirestore fireStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }





  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentUser: widget.currentUser,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:0.0),
                  child: Image.asset('images/investment_banner.png', height: 400, width: 400,alignment: Alignment.topLeft),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 140.0),
                  child: Text("Investments",
                    style:DefaultValues.kH1(context),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 170.0),
                  child: Text("Choose one of  these",
                    style:DefaultValues.kNormal2(context),

                  ),
                ),
              ],
            ),
          ),


          Expanded(
            flex:5,
            child: Container(
              height: 500,
              child:ListView(
                  shrinkWrap: false,

                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Tile(
                          imageSource: 'images/mutual.png',
                          //height: 120,
                          //width: 150,
                          title: 'Mutual Fund',
                          subText: 'Equity and debt funds',
                          color: color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Mutual Fund';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                        currentUser: widget.currentUser,
                                        //save: _save,
                                        titleMessage: name,
                                        investedAmount: 10,
                                        investmentDuration: 10,
                                        expectedRoi: 12,
                                        annualInvestment: 1,
                                        imageSource: 'images/mutual.png',

                            ),
                                  ),
                                ));
                          },

                        ),
                      ),

                      Expanded(
                        child: Tile(
                          imageSource: 'images/insurance.png',
                          //height: 20,
                          //width: 150,
                          title: 'Insurance',
                          subText: 'Life, health and term',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Insurance';
                            print('click on $name');
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 5,
                                      investmentDuration: 20,
                                      annualInvestment: 1,
                                      expectedRoi: 6,
                                      imageSource: 'images/insurance.png',

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
                          imageSource: 'images/bonds.png',
                         // height: 120,
                         // width: 150,
                          title: 'Debts & Bonds',
                          subText: 'Govt Bonds company debentures',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Debts and Bonds';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      annualInvestment: 1,
                                      expectedRoi: 6,
                                      imageSource: 'images/bonds.png',

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
                          title: 'Equity',
                          subText: 'Stock market investments',
                          color: color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Equity';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 5,
                                      annualInvestment: 1,
                                      expectedRoi: 15,
                                      imageSource: 'images/stock.png',

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
                          imageSource: 'images/real-estate.png',
                         // height: 120,
                         // width: 150,
                          title: 'Real Estate',
                          subText: 'Lands, houses, complexes etc.',
                          color:color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Real Estate';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 20,
                                      annualInvestment: 1,
                                      expectedRoi: 12,
                                      imageSource: 'images/real-estate.png',
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),

                      Expanded(
                        child: Tile(
                          imageSource: 'images/bank.png',
                        //  height: 120,
                        //  width: 150,
                          title: 'Bank FD',
                          subText: 'NSC, KVP, RD, Bank term deposits',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Bank FD';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 5,
                                      annualInvestment: 1,
                                      expectedRoi: 5,
                                      imageSource: 'images/bank.png',

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
                          title: 'Gold',
                          subText: 'Jewellery ',
                          color:alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Gold';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      annualInvestment: 1,
                                      expectedRoi: 10,
                                      imageSource: 'images/coin.png',
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
                          subText: 'Something not listed here',
                          color: color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Other';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InvestmentSheet(
                                      currentUser: widget.currentUser,
                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      annualInvestment: 1,
                                      expectedRoi: 12,
                                      imageSource: 'images/products.png',

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



        ],
      ),
      // body: Container(color: Colors.red,
      //           width: double.infinity,
      //     height: 10,
      // ) ,
      bottomNavigationBar: BottomNavigationBar(
      // type: BottomNavigationBarType.,
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
                 break;
             }

        },
        items: [


          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bullseye),
            label: 'Goals',


          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartPie),
            label: 'Dashboard',

          ),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.calculator),
              label: 'SIP Calculator'
          ),

        ],
      ),
    );
  }
}


