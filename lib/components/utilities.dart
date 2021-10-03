
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Utility{

  static String cutStringToCharacter(String str1, String str2, String source){

    int index1 = source.indexOf('[');
    int index2 = source.indexOf(']');

    return source.substring(index2);

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

  static Future<dynamic> timeoutAfter({required int sec, required Function() onTimeout}) async {
    return Future.delayed(Duration(seconds: sec), onTimeout);
  }

  static showMessageAndAsk({required BuildContext context, required String msg, required Function() takeAction}){

    showModalBottomSheet(
     isDismissible: false,
     // backgroundColor: Colors.green,
      context: context,
      builder: (context) => Container(
        height: 40.h,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.green,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:1.h),
                child: Center(
                    child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.amber,
                    child: Image.asset('images/check.png', height: 20,width: 20,),
                  ),


                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
              child:Text(msg,
              style: DefaultValues.kH3(context)),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:4.h),
              child: CommandButton(
                  onPressed: takeAction ,
                  buttonText: 'Go Back to Login Screen',
                  textSize: 12.sp,
                  buttonColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  textColor: Colors.white),
            )
          ],
        ),
      ),

    );
  }

}