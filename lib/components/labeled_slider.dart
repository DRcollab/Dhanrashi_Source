import 'package:dhanrashi_mvp/components/action_screen.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:dhanrashi_mvp/constants.dart';

class LabeledSlider extends StatefulWidget {
// const LabeledSlider({Key? key}) : super(key: key);

double sliderValue = 5.0; // Movement of slider
String labelText; //
double min = 1; // minimum value of the slider movement
double max = 10; // maximum value of the slider movement
//int divisions = 1;

double collector = 0;
String suffix = '';
final String? Function(String?) validator;

 Function(double)? onChanged;  // get the  changed value;

LabeledSlider({
  this.sliderValue=5.0,
  this.labelText='',
  this.min=1,
  this.max=10,
  //required this.controller,
  required this.validator,
  this.collector = 0,
  this.suffix ='',

  this.onChanged,
}
    );

@override
_LabeledSliderState createState() => _LabeledSliderState();
}





class _LabeledSliderState extends State<LabeledSlider> {

  var controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 2.0,right: 8.0,bottom: 0.0),
            child: NumberInputField(
              validator: widget.validator,
              controller: this.controller,
              label:widget.labelText,
              hintText: widget.sliderValue.toStringAsFixed(2),
              suffix: widget.suffix,
              getValue: (){
                setState(() {
                  widget.sliderValue = double.parse(double.parse( this.controller.text).toStringAsFixed(2));
                  widget.onChanged!(widget.sliderValue);

                });

              },
            ),

          ),
          Slider(
              min: widget.min,
              max:widget.max,
              //divisions: widget.divisions,
              activeColor: kPresentTheme.accentColor,
              inactiveColor: kPresentTheme.alternateColor,
              value: widget.sliderValue,//double.parse(widget.sliderValue.toStringAsFixed(2) ),

              onChanged:   (changeValue) {
                setState(() {
                  this.controller.clear();
                  widget.sliderValue = double.parse( changeValue.toStringAsFixed(2));
                  widget.onChanged!(widget.sliderValue);


                  print('slider value = ${widget.sliderValue}');
                });
              }
                //this.throwValue();
              )
        ],
      ),

    );
  }
}