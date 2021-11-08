
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Utility{


  static List<Color> warningColors = [
    Colors.orangeAccent,
    Colors.orangeAccent,
    Colors.orange,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.deepOrangeAccent,
    Colors.deepOrangeAccent,
    Colors.deepOrange,
    Colors.deepOrange,
    Colors.deepOrange,
    Colors.deepOrange,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,


  ];

  static var messages = {
    'timed_out': 'It seems there is an issue with your internet connection. Check your settings or watch for an wifi hotspot.\n\n'
    ' Your data will be stored as soon as internet restores. Meanwhile you are free to do other things.',
    'success_update_profile':'Your profile has been succesfully updated.' ,
    'empty':'It seems that  you have not entered any goal or investment.\n\n Let\'s start by adding your first Goal and Investment',
    'empty_goal':'It seems that  you have not entered any goal.\n\nLet\'s start by adding your first Goal',
    'empty_inv':'It seems that  you have not entered any investment.\n\nLet\'s start by adding your first Investment ',
    '':'',
  };


  static String customise(String str){

      if(str.contains('identifier')){
        return 'User with this email does not exist';
      }else if(str.contains('password is invalid')){
        return 'Invalid credentials';
      }else{
        return 'Something went wrong';
      }



  }

  static String cutStringToCharacter(String str1, String str2, String source){

    int index1 = source.indexOf('[');
    int index2 = source.indexOf(']');

    return source;//substring(index2);

  }

  static double changeToPeriodicDecimal(double val){


    if(val<1){
      return val*100;

    }else{
      return val;

    }
  }



  static String getPeriod(double val){
    if(val>0){
      if(val<1){
        return 'Thousand';

      }else{
        return 'Lac';

      }
    } else{
      return '';
    }


  }

  static showBanner(BuildContext context,String msg, Color color, Color textColor){
    return Container(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Text(msg,style: DefaultValues.kNormal3(context).copyWith(color:Colors.red),),
      ),
    );

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

  static showMessageAndAsk({

    required BuildContext context,
    required String msg,
    required Function() takeAction1,
     Function()? takeAction2,
    type = 0,
    String buttonText1 = '',
    String buttonText2 = '',


  }
    ){

    showModalBottomSheet(
     isDismissible: true,
     // backgroundColor: Colors.green,
      context: context,
      builder: (context) => Container(
        height: 40.h,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: (type==0) ?Colors.amber:(type==1) ?Colors.red:Colors.green,
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
              padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
              child:Text(msg,
              style: DefaultValues.kH3(context).copyWith(
                  color: (type == 0) ? Colors.red:Colors.black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top:6.h),
              child: CommandButton(
                  onPressed: takeAction1 ,
                  buttonText: buttonText1,
                  textSize: 12.sp,
                  buttonColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  textColor: Colors.white),
            ),
            (type == 0 || type == 1) ?Padding(
              padding:  EdgeInsets.symmetric(vertical:0.h),
              child: CommandButton(
                  onPressed: takeAction2! ,
                  buttonText: buttonText2,
                  textSize: 12.sp,
                  buttonColor: kPresentTheme.accentColor,
                  borderRadius: BorderRadius.circular(20),
                  textColor: Colors.white),
            ):SizedBox(),
          ],
        ),
      ),

    );
  }




}