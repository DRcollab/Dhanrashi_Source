
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

class Legend extends StatelessWidget {

  Color legendColor;
  String legendString;
  TextStyle legendStyle;

  Legend({
      required this.legendColor,
      required this.legendString,
      required this.legendStyle,
      });




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left:4.w, top:1.h, bottom: 0.5.h),
            child: Container(
              height: 10,width: 20,
              color: this.legendColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:4.0, top:1.h, bottom: 0.5.h),
            child: Text(this.legendString,style: this.legendStyle),

          ),
        ],
      ),
    );
  }


}
