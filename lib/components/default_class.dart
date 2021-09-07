
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart' as ts;

class DefaultValues{

  static double adaptForSmallDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static ts.TextStyle kTitleTextStyle(context){

    var kTitleTextStyle = ts.TextStyle(
      fontSize: 20.0*adaptForSmallDevice(context),
      fontFamily: 'Fredoka',
      color: Colors.white38,
    );

    return kTitleTextStyle;

  }




}