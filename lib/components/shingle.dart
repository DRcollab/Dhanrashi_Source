import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
import 'package:dhanrashi_mvp/models/investment.dart';
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class Shingle extends StatelessWidget {
  //const Shingle({Key? key}) : super(key: key);

  String title;
  String subtitle;
  String prefix; // used to store the type prefix to determine which type of investment
  String value = '';
  String leadingImage ='';
  Widget? trailing;
  Widget? trailing2;
  Color barColor;
  late double maxHeight;
  String updateKey ='';
  Function() onPressed;
  String type = 'goal';
  String text = '';
  String text2 = '';
  late IconData icon1;
  late IconData? icon2;
  String highlight = '';
  bool hasExtraText = false;



  Shingle( {
    required this.type,
    required this.title,
    required this.subtitle,
    this.value= '',
    this.leadingImage ='',
    this.trailing,
    this.barColor=Colors.white,
    this.maxHeight = 1,
    this.updateKey = '',
    required this.onPressed,
    this.text = '',
    this.text2 = '',
    this.icon1 = Icons.done,
    this.icon2,
    this.highlight = '',
    this.hasExtraText = false,
    this.trailing2,
    this.prefix='',
  } );



  late Goal goal;
  late Investment investment;





  @override
  Widget build(BuildContext context) {
    return  Card(

        child: Stack(

          children: [
            Container(
              height: this.maxHeight,
              width: 2.w,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                color: this.barColor,

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: this.onPressed,
                child: ListTile(
                      leading:Stack(
                        children: [
                          Image.asset(this.leadingImage,height: 10.h,width: 10.w,),

                        ],
                      ),
                      trailing: Padding(
                        padding:EdgeInsets.only(left : 3.w),
                        child: this.trailing,
                      ),
                      title: Padding(
                        padding:  EdgeInsets.only(top:1.h),
                        child: Text(this.title,style: DefaultValues.kH3(context),),
                      ),
                      subtitle: Padding(
                        padding:  EdgeInsets.only(top:1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( this.subtitle, style:DefaultValues.kNormal3(context)),
                            this.text!=''? Text(this.text, style:DefaultValues.kNormal3(context)):SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(top: 1.h, left:0.5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(icon1, color:kPresentTheme.accentColor,size:16.sp*DefaultValues.adaptForSmallDevice(context)),
                                  Padding(
                                    padding:EdgeInsets.only(left : 1.5.w),
                                    child: Text( this.value, style: DefaultValues.kH4(context),),
                                  ),
                                 // Image.asset('images/roi.png', height: 0.5.h,width: 0.5.w,),
                                  icon2 != null ?Padding(
                                    padding: EdgeInsets.only(left : 3.w),
                                    child: Icon(icon2, color:kPresentTheme.accentColor,size:16.sp*DefaultValues.adaptForSmallDevice(context)),
                                  ):SizedBox(),
                                  this.text2!='' ?Padding(
                                    padding: EdgeInsets.only(left : 2.w),
                                    child: Text( this.text2, style: DefaultValues.kH4(context),),
                                  ):SizedBox(),

                                ],
                              ),
                            ),
                            this.highlight!='' ? Padding(
                              padding: EdgeInsets.only(top:1.h, bottom: 1.h),
                              child: Text(this.highlight, style: DefaultValues.kH3(context),),
                            ):SizedBox(),
                          ],
                        ),
                      ),

                    ),

              ),
            ),
          ],
        ),
      );
  }
}
