
import 'package:dhanrashi_mvp/components/irregular_shapes.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ActionSheet extends StatefulWidget {
 // const ActionSheet({Key? key}) : super(key: key);

  String titleMessage;
  var textVar = TextEditingController();
  String display = '';

  ActionSheet({this.titleMessage=''});
  @override
  _ActionSheetState createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {


  //String display = '';
  double sliderValue = 5;

  double investAmount = 0;
  int year = 0;
  int roi = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: CurvePainter(type: 3),
        child: Wrap(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Text(widget.titleMessage, style: kH1,)),

           LabeledSlider(
             sliderValue: 5,
             min: 1,
             max: 100,
             labelText: 'Invested Amount (in Lakhs)',
           ),
            LabeledSlider(
              min: 1,
              max:30,
              labelText: 'Expected return ',
              sliderValue: 15,
            ),
            LabeledSlider(
              min: 1,
              max: 30,
              labelText: 'Time Period',
              sliderValue: 5,
            ),
            Center(
              child: CommandButton(
                buttonText: 'Save Investment',
                onPressed:(){

              }, borderRadius: BorderRadius.circular(10),),
            ),
            Container(
              child: charts.PieChart([


              ]),
            )
          ],
        ),
      ),
    );
  }
}



class LabeledSlider extends StatefulWidget {
 // const LabeledSlider({Key? key}) : super(key: key);

  int sliderValue = 5;
  String labelText;
  double min;
  double max;
  int divisions ;
  LabeledSlider({this.sliderValue, this.labelText='', this.min, this.max});

  @override
  _LabeledSliderState createState() => _LabeledSliderState();
}





class _LabeledSliderState extends State<LabeledSlider> {
  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0,bottom: 0.0),
            child: LabeledTextField(
              label:widget.labelText,
              hintText: widget.sliderValue.toString(),
            ),

          ),
          Slider(
              min: widget.min,
              max:widget.max,
              divisions: widget.divisions,
              activeColor: kPresentTheme.accentButtonColor,
              inactiveColor: kPresentTheme.navigationColor,
              value: widget.sliderValue.toDouble() ,

              onChanged: (changeValue){
                setState(() {
                  widget.sliderValue = changeValue.round();
                  // display = changeValue.toString();

                });

              })
        ],
      ),

    );
  }
}
