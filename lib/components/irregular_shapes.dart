import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;


class CurvePainter extends CustomPainter {

  int type = 0;

   UI.Image image;

  CurvePainter({this.type = 0});

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    // throw UnimplementedError();

  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(bytes);

  }

  void sideCurveGreen( Canvas canvas, Size size, Color color){

    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();

    paint.color = color; // Color(0xFF004752);


    path.moveTo(size.width*.775, 0);
    path.quadraticBezierTo(size.width*0.835, size.height * 0.075,  size.width * 0.865, size.height*.250);
    path.quadraticBezierTo(size.width * 0.875, size.height*0.375, size.width, size.height*0.500);
    path.lineTo(size.width, size.height * 0.06);
    path.quadraticBezierTo(size.width, 0, size.width*0.94 , 0);
    //path.lineTo(size.width*0.875 , 0);
    canvas.drawPath(path, paint);
  }


  void sideCurveLime(Canvas canvas, Size size, Color color){
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();

    paint.color = color;

    path.moveTo(size.width*0.865, 0);
   // path.quadraticBezierTo(size.width*0.835, size.height * 0.325,  size.width * 0.865, size.height*.250);
   path.quadraticBezierTo(size.width * 0.725, size.height * 0.325, size.width, size.height*0.650);
    path.lineTo(size.width, size.height * 0.125);
    canvas.drawPath(path, paint);

  }

  void bottomWave(Canvas canvas, Size size, Color color){
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();

    paint.color = color;

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);

  }

  void upperWave(Canvas canvas , Size size, Color color){
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();

    paint.color = color;

    path.moveTo(0, size.height * 0.1 );
    path.quadraticBezierTo(size.width*0.25, size.height*0.135, size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.75, size.width * 0.116, size.width, size.height*0.1);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height*0.0933);

    canvas.drawPath(path, paint);
    loadImage('images/logo_coloured.png');
    var paint1 = Paint();
   // canvas.drawImage(image, Offset.zero, paint1);

   // canvas.drawImage(, offset, paint)
  }


  void dividingWave(Canvas canvas, Size size, Color color){


    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();

    paint.color = color;

    path.moveTo(0, size.height * 0.500);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.655,
        size.width * 0.5, size.height * 0.500);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.375,
        size.width * 1.0, size.height * 0.500);
    path.lineTo(size.width, size.height * 0.92);
    path.quadraticBezierTo(size.width , size.height, size.width *0.92, size.height);
    path.lineTo(size.width * 0.08, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height*0.92);
    canvas.drawPath(path, paint);



  }


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();

    paint.style = PaintingStyle.fill;

    if(type == 0) {
      sideCurveLime(canvas, size, Color(0xffb5c210));// Color(0xDDe8f54a)

      sideCurveGreen(canvas, size, Color(0xFF004752));
    }
    else if(type == 1){

      //upperWave(canvas, size, Color(0xffb5c210),);
    }
    else if(type == 2){

      dividingWave(canvas, size, Color(0xFF004752));
    }


  }



}






