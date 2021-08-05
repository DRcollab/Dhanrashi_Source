import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:dhanrashi_mvp/constants.dart';

class LabeledSlider extends StatefulWidget {
// const LabeledSlider({Key? key}) : super(key: key);

int sliderValue = 5;
String labelText;
double min = 1;
double max = 10;
int divisions = 1;
var controller ;
double collector = 0;
final String? Function(String?) validator;

LabeledSlider({
  this.sliderValue=5,
  this.labelText='',
  this.min=1,
  this.max=10,
  this.controller,
  required this.validator,
  required this.collector,

}
    );

@override
_LabeledSliderState createState() => _LabeledSliderState();
}





class _LabeledSliderState extends State<LabeledSlider> {

  void throwValue(){
    setState(() {
      widget.collector = widget.sliderValue.toDouble();
    });

    print(widget.collector);
  }


  @override
  Widget build(BuildContext context) {
    return Card(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 2.0,right: 8.0,bottom: 0.0),
            child: LabeledTextField(
              validator: widget.validator,
              controller: widget.controller,
              label:widget.labelText,
              hintText: widget.sliderValue.toString(),
            ),

          ),
          Slider(
              min: widget.min,
              max:widget.max,
              //divisions: widget.divisions,
              activeColor: kPresentTheme.accentButtonColor,
              inactiveColor: kPresentTheme.navigationColor,
              value: widget.sliderValue.toDouble() ,

              onChanged: (changeValue){
                setState(() {
                  widget.sliderValue = changeValue.round();
                  this.throwValue();

                  //print(changeValue);

                  // display = changeValue.toString();

                });

              })
        ],
      ),

    );
  }
}