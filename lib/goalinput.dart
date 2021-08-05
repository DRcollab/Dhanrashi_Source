import 'package:dhanrashi_mvp/components/custom_card.dart';

import 'components/custom_scaffold.dart';
import 'components/round_button.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


class GoalInputScreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: GoalInput(),);

    MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: SafeArea(child: GoalInput()),
        ));
  }
}

class GoalInput extends StatefulWidget {
  const GoalInput({Key? key}) : super(key: key);

  @override
  _GoalInputState createState() => _GoalInputState();
}

class _GoalInputState extends State<GoalInput> {
  List<String> image_file = ['images/famicar.png', 'images/house.jpg'];
  int i = 0;
  int amount = 1;
  int year = 5;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "So , what you want your Goal about?",
                style: kNormalTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InputCard(
              titleText: 'Choose your Goal ',
              children: [
                Image.asset(image_file[i % 2]),],

            ),
          ),
          // ReportCard(borderRadius:BorderRadius.only(topLeft: Radius.circular(20),
          //     topRight: Radius.circular(20.0),),
          // children: [
          //     Row(
          //       children: [
          //         Icon(Icons.monetization_on,
          //                     size: 60.0,
          //                     color: kDarkColor,)
          //       ],
          //
          //     ),
          //
          //   Column(
          //     children: [
          //
          //     ],
          //   )
          // ],
          // )
          // Card(
          //   color: Color(0xffffffff),
          //   shadowColor: kDarkColor,
          //   elevation: 5,
          //   shape: RoundedRectangleBorder(
          //     side: BorderSide(color: Color(0xFF193F6C), width: 1),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           Icons.monetization_on,
          //           size: 60.0,
          //           color: kDarkColor,
          //         ),
          //       ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         // crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   "How much  in  mind?",
          //                   style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                     color: kDarkColor,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Slider(
          //             value: amount.toDouble(),
          //             min: 1,
          //             max: 99,
          //             onChanged: (double newValue) {
          //               setState(() {
          //                 amount = newValue.toInt();
          //               });
          //             },
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               "(move the slider to change the number",
          //               style: TextStyle(
          //                 fontStyle: FontStyle.italic,
          //                 color: kDarkColor,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Text(
          //         amount.toString() + "L",
          //         style: TextStyle(fontSize: 40),
          //       )
          //     ],
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Card(
          //     color: Colors.white,
          //     shadowColor: kDarkColor,
          //     elevation: 5,
          //     shape: RoundedRectangleBorder(
          //       side: BorderSide(color: Color(0xFF193F6C), width: 1),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             Icons.timelapse,
          //             size: 60.0,
          //             color: kDarkColor,
          //           ),
          //         ),
          //         Column(
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 "How long you want to wait?",
          //                 style: TextStyle(
          //                   fontSize: 20.0,
          //                   fontWeight: FontWeight.bold,
          //                   color: kDarkColor,
          //                 ),
          //               ),
          //             ),
          //             Slider(
          //               value: year.toDouble(),
          //               min: 1,
          //               max: 15,
          //               onChanged: (double newValue) {
          //                 setState(() {
          //                   year = newValue.toInt();
          //                 });
          //               },
          //             ),
          //             // onChanged: onChanged)
          //             Text(
          //               "(Move the slider to change the number )",
          //               style: TextStyle(
          //                 color: kDarkColor,
          //                 fontStyle: FontStyle.italic,
          //               ),
          //             )
          //           ],
          //         ),
          //         Text(
          //           year.toString() + "Y",
          //           style: TextStyle(fontSize: 30),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: Card(
          //     child: Column(),
          //   ),
          // )
        ],
      ),
    );
  }
}
