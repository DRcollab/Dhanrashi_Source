
import 'package:flutter/material.dart';

class Utility{

  static String cutStringToCharacter(String str1, String str2, String source){

    int index1 = source.indexOf('[');
    int index2 = source.indexOf(']');

    return source.substring(index2);

  }

  static double adaptForSmallDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // For tiny devices.
    if (size.height < 600) {
      return 0.6;
    }
    // For normal devices.
    return 1.0;
  }

  static showErrorMessage(BuildContext context, String e){
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color:Colors.red,

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(e.toString().substring(e.toString().indexOf(']')+1),
            style: TextStyle(
              color:Colors.white,

            ),),
        ),
      ),

    );
  }
}