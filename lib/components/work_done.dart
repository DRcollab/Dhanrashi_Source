import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:loading_gifs/loading_gifs.dart';


class WorkDone extends StatefulWidget {
  
  bool isComplete = false;
  String whatToAdd = 'Investment';

  WorkDone({
    this.isComplete=false,
    this.whatToAdd = 'Investment',
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
      _height = 400;
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
          color: color,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.amber,
                  child: Image.asset('images/check.png',

                    height: 80,width: 80,),
                ),
              ),
              Text('Your ${this.widget.whatToAdd} \nadded successfully ', style: DefaultValues.kH4(context),),
            ],
          )) :Image.asset(circularProgressIndicator, scale: 5)
    );
  }
}
