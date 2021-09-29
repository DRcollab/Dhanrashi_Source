import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_gifs/loading_gifs.dart';


class WorkDone extends StatelessWidget {
  
  bool isComplete = false;
  String whatToAdd = 'Investment';

  WorkDone({
    this.isComplete=false,
    this.whatToAdd = 'Investment',
  });





  @override
  Widget build(BuildContext context) {
    return Container(
      child: isComplete ? AnimatedContainer(
        duration: Duration(seconds: 1),
          height: 400,
          width: 100.w,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: Image.asset('images/check_1.gif',

                  height: 100,width: 100,),
              ),
              Text('Your ${this.whatToAdd} \nadded successfully ', style: DefaultValues.kH4(context),),
            ],
          )) :Image.asset(circularProgressIndicator, scale: 5)
    );
  }
}
