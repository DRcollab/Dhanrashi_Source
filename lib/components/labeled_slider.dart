import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:sizer/sizer.dart';
class LabeledSlider extends StatefulWidget {
// const LabeledSlider({Key? key}) : super(key: key);

bool textEditable = true;
double sliderValue = 5.0; // Movement of slider
String labelText; //
double min = 1; // minimum value of the slider movement
double max = 10; // maximum value of the slider movement
//int divisions = 1;
int textPrecision = 2;
double collector = 0;
String suffix = '';
final  Function() validator;
Function()? onEditingComplete;

 Function(double)? onChanged;  // get the  changed value;

LabeledSlider({
  this.onEditingComplete,
  this.sliderValue=5.0,
  this.labelText='',
  this.min=1,
  this.max=10,
  //required this.controller,
  required this.validator,
  this.collector = 0,
  this.suffix ='',
  this.textPrecision = 2,
  this.textEditable = true,
  this.onChanged,
}
    );

@override
_LabeledSliderState createState() => _LabeledSliderState();
}





class _LabeledSliderState extends State<LabeledSlider> {

  var controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController(
      text: widget.sliderValue.toStringAsFixed(widget.textPrecision),
    );
        //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Padding(
            padding: DefaultValues.kDefaultHorizontalSymmetricPadding(context),
            child: NumberInputField(
              onCompleteEditing: widget.onEditingComplete,
              validator: widget.validator,
              enabled: widget.textEditable,
              //validator: widget.validator,
              controller: this.controller,
              label:widget.labelText,
              hintText: '',
              suffix: widget.suffix,
              getValue: (){
                setState(() {
                  widget.sliderValue = double.parse(double.parse( this.controller.text).roundToDouble().toStringAsFixed(2));
                  widget.onChanged!(widget.sliderValue);
                  print(this.controller.text);
                  print( double.parse(this.controller.text).roundToDouble() );
                });

              },
            ),

          ),
          Padding(
            padding: DefaultValues.kAdaptedTopPadding(context, 6.h),
            child: Slider(
                min: widget.min,
                max:widget.max,
             //   divisions: (widget.max-widget.min+1).toInt()*2,
                //divisions: widget.divisions,
                activeColor: kPresentTheme.accentColor,
                inactiveColor: kPresentTheme.alternateColor,
                value: widget.sliderValue,//double.parse(widget.sliderValue.toStringAsFixed(2) ),

                onChanged:   (changeValue) {
                  setState(() {
                    print(this.controller.text);
                    print( double.parse(this.controller.text).roundToDouble() );
                    this.controller.clear();
                    widget.sliderValue = double.parse( changeValue.toStringAsFixed(2));
                    widget.onChanged!(widget.sliderValue);
                    controller = TextEditingController(
                      text: widget.sliderValue.toStringAsFixed(widget.textPrecision),

                    );


                  });
                }
                  //this.throwValue();
                ),
          )
        ],
      ),

    );
  }
}