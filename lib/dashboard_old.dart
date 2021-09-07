import 'package:dhanrashi_mvp/components/irregular_shapes.dart';

import '/components/custom_scaffold.dart';

import 'profiler.dart';
import 'package:flutter/material.dart';
import 'investmentinput.dart';
import 'components/round_button.dart';
import 'components/constants.dart';
import 'components/custom_card.dart';
import 'data/goal_class.dart';
import 'package:dhanrashi_mvp/models/investment_class.dart';
import 'package:dhanrashi_mvp/models/user_data_class.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashBoard extends StatefulWidget {

 // Investment investments;
  //Goal goals ;
  UserData currentUser = UserData.create();

  String currentUserName = ""; // to recieve the current user from login screen

  DashBoard({investments, goals, currentUser}){
    currentUserName = currentUser.firstName();
  }

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  String currentUser = "";

  List<String> analysedComment = [
    "Your investments are lagging to meet your goals",
    "Your investments are doing fine",

  ];


  @override
  void initState() {
    currentUser = widget.currentUserName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //TODO analysis calculator to be executed here



    return CustomScaffold(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         // SizedBox(height: 5.0, width: 200,child: Container(color:kLightButtonColor),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             // SizedBox(height: 2.0, width:90,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(
                  "Hi,$currentUser",
                  style: TextStyle(
                    color: kPresentTheme.highLightColor,
                    fontSize: 24.0,
                    fontFamily: "Fredoka",
                  ),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFe8f54a),
                backgroundImage: AssetImage('images/bubu1.jpg'),
              ),
            ],
          ),
          Text(
            analysedComment[0],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: kPresentTheme.lightWeightColor,
              fontWeight: FontWeight.bold,

            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/dchart.png'),
                  Image.asset('images/legend.png')
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: AnalysisCard(),
          ),
          //-----
          //GoalViewPanel(),
          //InvestmentViewPanel(),
        ],
      ),
    );
  }
}

class UpperPanel extends StatefulWidget {
  const UpperPanel({Key? key}) : super(key: key);

  @override
  _UpperPanelState createState() => _UpperPanelState();
}

class _UpperPanelState extends State<UpperPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: CurvePainter(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: 2.0, width:90,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "Hi, Shubhadeep",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontFamily: "Fredoka",
                ),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFe8f54a),
              backgroundImage: AssetImage('images/bubu1.jpg'),
            ),
            Text(
              "Your investments are lagging to meet your goals",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: kPresentTheme.accentColor,
                fontWeight: FontWeight.bold,

              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/dchart.png'),
                    Image.asset('images/legend.png')
                  ],
                ),
              ),
            ),
          ],
        ),


      )
      ,
    );
  } // build
} // End of UpperPanel class.

class AnalysisCard extends StatefulWidget {
  //const AnalysisCard({Key? key}) : super(key: key);

  @override
  _AnalysisCardState createState() => _AnalysisCardState();
}

class _AnalysisCardState extends State<AnalysisCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ReportCard(
          baseColor: kPresentTheme.influenceColors[0],
          requiredTitleBar: false,
          titleText: "Your Portfolio Analysis",
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 18),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "You have  ",
                                style: TextStyle(fontSize: 25.0)),
                            TextSpan(
                              text: " 3 ",
                              style: TextStyle(
                                  fontSize: 50,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(blurRadius: 2.0,
                                  color:Colors.blueAccent,
                                  offset: Offset(1.5,1.5))
                                ]// Shadow(blurRadius: 2)
                              ),
                            ),
                            TextSpan(
                              text: " Goals",
                              style: TextStyle(fontSize: 25.0),
                            )
                          ],

                          //
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 18),
                      child: Text("One is approaching  ", style:DefaultValues.kH2(context),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 18),
                      child: Text("Your Investment are..", style:DefaultValues.kH2(context),),
                    )
                  ],
                ),
                SizedBox(
                  width: 2.0,
                  height: 90,
                  child: Container(color: kPresentTheme.accentColor),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.play_arrow,
                        size: 20.0,
                      ),
                    ),
                    RoundButton(
                      icon: Icons.add,
                      onPress: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => GoalInputScreen()));
                      },
                    )
                  ],
                )
              ],
            ),
          ],
        ), // Goal View Column
        ReportCard(
          //titleText: 'Investment Anlysis',
          requiredTitleBar: false,
          baseColor: kPresentTheme.influenceColors[1],
          borderRadius: BorderRadius.only(
            topRight: Radius.zero,
            topLeft: Radius.zero,
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          children: [
            Image.asset('images/bar_chart.png'),
          ],
        )
      ],
    );
  }
}

class GoalViewPanel extends StatefulWidget {

  UserData currentUser = UserData.create();
  GoalViewPanel({ required this.currentUser});

  @override
  _GoalViewPanelState createState() => _GoalViewPanelState();
}

class _GoalViewPanelState extends State<GoalViewPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shadowColor: Color(0xFF193F6C),
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFF193F6C), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(28.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      " You Have 3 Goals ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kPresentTheme.accentColor,
                      ),
                    ),
                    Text("1 is approaching fast"),
                  ],
                ),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                    Expanded(
                      child: FloatingActionButton(
                          heroTag: "btn1",
                          child: Icon(Icons.add),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProfilerPage(currentUser: widget.currentUser )),
                            // );
                          }
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} // End of Goal view class

class InvestmentViewPanel extends StatefulWidget {
  const InvestmentViewPanel({Key? key}) : super(key: key);



  @override
  _InvestmentViewPanelState createState() => _InvestmentViewPanelState();
}

class _InvestmentViewPanelState extends State<InvestmentViewPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
              shadowColor: Color(0xFF193F6C),
              // color:Colo
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Color(0xFF193F6C), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      //alignment: AlignmentGeometry,
                      child: Image.asset('images/bar_chart.png'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 30.0,
                          ),
                          FloatingActionButton(
                            heroTag: 'btn2',
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => GoalInputScreen()),
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  } // end of build
} //End of class

// class DashBoard_2 extends StatefulWidget {
//   const DashBoard_2({Key? key}) : super(key: key);
//
//   @override
//   _DashBoard_2State createState() => _DashBoard_2State();
// }
//
// class _DashBoard_2State extends State<DashBoard_2> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         //color: Colors.deepPurple,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           colors: [Colors.deepPurple, Colors.amber],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: [.4, 1],
//         )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             UpperPanel(),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: GoalViewPanel(currentUser: widget.,),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: InvestmentViewPanel(),
//             ),
//           ],
//         ));
//   }
// }
