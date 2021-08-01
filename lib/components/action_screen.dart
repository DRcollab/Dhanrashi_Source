
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';

class ActionSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  String titleMessage;

  ActionSheet({this.titleMessage=''});
  @override
  _ActionSheetState createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: CurvePainter(type: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.titleMessage, style: kH1,),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: CustomTextField(
                label: "Investment Amount",

               // hintText: 'current value of investment',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: CustomTextField(
                //hintText: 'annual investment amount',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: CustomTextField(
                //hintText: 'duration you want to continue ',
              ),
            ),
          CommandButton(onPressed: (){}, borderRadius: BorderRadius.circular(10), buttonText: "Add Investment",),

          ],
        ),
      ),
    );
  }
}
