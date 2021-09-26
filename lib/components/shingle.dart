import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:sizer/sizer.dart';

class Shingle extends StatelessWidget {
  //const Shingle({Key? key}) : super(key: key);

  String title;
  String subtitle;
  String value = '';
  String leadingImage ='';
  Widget? trailing;
  Color barColor;
  late double maxHeight;

  Shingle( {
    required this.title,
    required this.subtitle,
    this.value= '',
    this.leadingImage ='',
    this.trailing,
    this.barColor=Colors.white,
    this.maxHeight = 1,
  } );

  @override
  Widget build(BuildContext context) {
    return  Card(

        child: Stack(

          children: [
            Container(
              height: maxHeight,
              width: 2.w,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                color: this.barColor,

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: ListTile(
                leading:Stack(
                  children: [
                    Image.asset(this.leadingImage,height: 10.h,width: 10.w,),

                  ],
                ),
                trailing: trailing,
                title: Text(this.title,style: DefaultValues.kH3(context),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( this.subtitle),
                    Text( value)
                  ],
                ),

              ),
            ),
          ],
        ),
      );
  }
}
