import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_gifs/loading_gifs.dart';


class WorkDone extends StatefulWidget {
  
  bool isComplete = false;
  String whatToAdd = 'Investment';
  String whatToDo = 'Save';
  bool timedOut = false;

  WorkDone({
    this.isComplete=false,
    this.whatToAdd = 'Investment',
    this.whatToDo = 'Save',
    this.timedOut = false,
  });

  @override
  _WorkDoneState createState() => _WorkDoneState();
}

class _WorkDoneState extends State<WorkDone> {

  double _width = 20;
  double _height = 20;
  Color color = Colors.white;



  @override
  void initState() {
    _width = 20;
    _height = 20;
    color = Colors.white;

    super.initState();

    setState(() {
      _width = 100.w;
      _height = 50.h;
      color = Colors.green;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isComplete ? AnimatedContainer(
          duration: Duration(seconds: 10),
          width: _width,
          height: _height,
          color:  color,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 6.h, horizontal: 2.w),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.amber,
                  child: Image.asset('images/check.png',

                    height: 80,width: 80,),
                ),
              ),
               Text('Your ${this.widget.whatToAdd} is \n${this.widget.whatToDo}d successfully ', style: DefaultValues.kH2(context),)

            ],
          )) :!widget.timedOut ? Image.asset(kPresentTheme.progressIndicator, scale: 3) :
            Container(

                child: Padding(
                  padding:  EdgeInsets.only(top:8.h, bottom: 8.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Image.asset('images/connection_lost.png', scale: 5, height: 18.h,width: 50.w,),
                      ),
                      Container(
                        color:Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                            child: Text(DefaultValues.messages['timed_out']!, style: DefaultValues.kH2(context),),
                          ),
                      )
                    ],
                  ),
                ),
            )
    );
  }
}
