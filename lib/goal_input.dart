import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
//import 'components/tile_class.dart';
import 'dashboard.dart';
import 'data/investment_class.dart';
import 'components/action_screen.dart';
import 'data/user_data_class.dart';
import 'investmentinput.dart';





class GoalsInputScreen extends StatefulWidget {
  //const InvestmentInputScreen({Key? key}) : super(key: key);

  DRUserAccess? currentUser;



GoalsInputScreen({required this.currentUser});

  @override
  _GoalsInputScreenState createState() => _GoalsInputScreenState();
}

class _GoalsInputScreenState extends State<GoalsInputScreen> {
  Color color = kPresentTheme.accentColor;

  Color alternateColor = kPresentTheme.alternateColor;

  Color titleColor = Colors.black;

  var investment = Investment.create();

  String name = '';

  double currentInvestmentAmount = 0;

  double annualInvestmentAmount = 0;

  double investmentRoi = 0;

  double investmentDuration = 0;
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:0.0),
                  child: Image.asset('images/goals.png', height: 400, width: 400,alignment: Alignment.topLeft),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 140.0),
                  child: Text("Goals",
                    style: kH1,

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 170.0),
                  child: Text("Choose one of  these",
                    style: kNormal2,

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
                          imageSource: 'images/car.png',
                          //height: 120,
                          //width: 150,
                          title: 'Buy car',
                          subText: 'dream car',
                          color: color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Own a car';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      expectedRoi: 12,
                                      imageSource: 'images/car.png',

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
                          title: 'My Dream ',
                          subText: 'House',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Building my own House';
                            print('click on $name');
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 5,
                                      investmentDuration: 20,
                                      expectedRoi: 6,
                                      imageSource: 'images/house.png',

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
                          title: 'Children',
                          subText: 'Education',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Children Education';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      expectedRoi: 6,
                                      imageSource: 'images/education.png',

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
                          subText: 'a peaceful life',
                          color: color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'Retirement';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 5,
                                      expectedRoi: 15,
                                      imageSource: 'images/pension.png',

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
                          // height: 120,
                          // width: 150,
                          title: 'Domestic',
                          subText: 'tours and travel',
                          color:color,
                          titleColor: Colors.white60,
                          onPressed: (){
                            name = 'See my country';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 20,
                                      expectedRoi: 12,
                                      imageSource: 'images/tour.png',
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ),

                      Expanded(
                        child: Tile(
                          imageSource: 'images/destination.png',
                          //  height: 120,
                          //  width: 150,
                          title: 'Foreign',
                          subText: 'Tour',
                          color: alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Foreign tour';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 5,
                                      expectedRoi: 5,
                                      imageSource: 'images/destination.png',

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
                          title: 'Parents Health',
                          subText: ' ',
                          color:alternateColor,
                          titleColor: titleColor,
                          onPressed: (){
                            name = 'Parents Health';

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
                                      expectedRoi: 10,
                                      imageSource: 'images/healthcare.png',
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
                                    child: ActionSheet(

                                      titleMessage: name,
                                      investedAmount: 10,
                                      investmentDuration: 10,
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
              break;
          }
        },

        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.chartLine),
            label: 'Investment',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartPie),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calculator),
            label: 'SIP Calculator',
          )
        ],
      ),
    );
  }
}


