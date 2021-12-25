import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
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
int? divisions;
String suffix = '';
double threshold = 0;
bool perpetualActive = false;
final  Function() validator;
Function()? onEditingComplete;
bool implementWarning = false;
 Function(double)? onChanged;  // get the  changed value;
 late Color activeColor;
 Widget? suggestiveIcon;
LabeledSlider({
  this.onEditingComplete,
  this.sliderValue=5.0,
  this.labelText='',
  this.min=1,
  this.max=10,
  //required this.controller,
  this.suggestiveIcon,
  required this.validator,
  this.collector = 0,
  this.suffix ='',
  this.textPrecision = 2,
  this.textEditable = true,
  this.onChanged,
  this.perpetualActive = false,
  this.implementWarning = false,
  this.threshold = 0,
  this.divisions,
  required this.activeColor,
}
    );

@override
_LabeledSliderState createState() => _LabeledSliderState();
}





class _LabeledSliderState extends State<LabeledSlider> {

  var controller = TextEditingController();
  double variableMax = 0;
  double variableMin = 0;
  late Color activeColor;
  String label = '';
  @override
  void initState() {

    activeColor = widget.activeColor;
    controller = TextEditingController(
      text: widget.sliderValue.toStringAsFixed(widget.textPrecision),
    );
    variableMax = widget.max;
    variableMin = widget.min;
        //
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
              onFocusLost: widget.onEditingComplete,
              onCompleteEditing: widget.onEditingComplete,
              validator: widget.validator,
              enabled: widget.textEditable,
              //validator: widget.validator,
              controller: this.controller,
              label:widget.labelText,
              suggestiveIcon: widget.suggestiveIcon != null ? widget.suggestiveIcon! : SizedBox(),
              hintText: '',
              suffix: widget.suffix,
              getValue: (){
                setState(() {

                  double val = double.parse(double.parse(this.controller.text).toStringAsFixed(2));
                  if( val > widget.min) {

                    if(val<1.0){
                        if(val<0.1){
                          variableMax = 0.1;
                          variableMin = 0.001;
                          widget.divisions = 50;
                        }
                        variableMax = 1;
                        variableMin = 0.01;
                        widget.divisions = 50;
                    }

                   widget.sliderValue = val;
                  }else {
                    widget.sliderValue = widget.min;
                    this.controller.text = widget.min.toString();
                  }


                 widget.onChanged!(widget.sliderValue);
                  // if(widget.perpetualActive){
                  //   if(val>widget.max){
                  //     variableMax = widget.max + widget.max;
                  //     variableMin = widget.max;
                  //   }
                  // }

                });

              },
            ),

          ),
          Padding(
            padding: DefaultValues.kAdaptedTopPadding(context, 6.h),
            child: Slider(
                min: variableMin,
                max:variableMax,
                label:label,
             //   divisions: (widget.max-widget.min+1).toInt()*2,
                //divisions: widget.divisions,
                activeColor: activeColor,
                inactiveColor: kPresentTheme.alternateColor,
                value: widget.sliderValue,//double.parse(widget.sliderValue.toStringAsFixed(2) ),
                divisions: widget.divisions,
                onChanged:   (changeValue) {

                  setState(() {


                    if(changeValue < widget.min){
                      changeValue = widget.min;
                    }

                     // if(widget.perpetualActive) {
                     //     if(changeValue>widget.sliderValue){
                     //
                     //       variableMax++;
                     //       variableMin++;
                     //     }
                     //     else{
                     //       variableMax>= changeValue ? variableMax-- : variableMax = changeValue;
                     //       variableMin>=widget.min ? variableMin-- : variableMin = widget.min;
                     //     }
                     //   print("C:$changeValue");
                     //
                     // }

                    if(widget.implementWarning){
                      if(changeValue>widget.threshold){
                        activeColor = Utility.warningColors[(changeValue%widget.threshold).toInt()];
                        label='expecting so much return is not logical';
                      }
                      else{
                        activeColor = widget.activeColor;
                      }
                    }

                    print(this.controller.text);
                    print( double.parse(this.controller.text).roundToDouble() );
                    this.controller.clear();
                    widget.sliderValue = double.parse( changeValue.toStringAsFixed(1));
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