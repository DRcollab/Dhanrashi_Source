import 'package:dhanrashi_mvp/components/investment_entry_sheet.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:sizer/sizer.dart';
class LabeledSlider extends StatefulWidget {
// const LabeledSlider({Key? key}) : super(key: key);

bool textEditable = true;
String internalErrorMsg='';
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
 Function(double, bool)? onChanged;  // get the  changed value;
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
  this.internalErrorMsg = '',
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
              onChanged: (value, internal){

                if(value>widget.max){
                  value = widget.max;
                }else if(value< widget.min){
                  value = widget.min;
                }
                widget.onChanged!(value, internal);
               // value = double.parse(double.parse(this.controller.text).toStringAsFixed(2));
              },
              getValue: (){
                double val = 0;
                setState(() {

                  if(this.controller.text !='') {
                     val = double.parse(double.parse(this.controller.text)
                        .toStringAsFixed(2));

                  }else{
                    val = 0;

                  }
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


                 widget.onChanged!(widget.sliderValue, true);


                });

              },
            ),

          ),
          Center(child: Text(widget.internalErrorMsg, style: TextStyle(color: Colors.red),)),// Used to display error when validation fails
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
                    }else if(changeValue > widget.max){
                      changeValue = widget.max;

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


                    this.controller.clear();
                    widget.sliderValue = double.parse( changeValue.toStringAsFixed(1));
                   // print('change value : ${widget.sliderValue}');
                    widget.onChanged!(widget.sliderValue,true);
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