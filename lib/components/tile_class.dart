import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class Tile extends StatelessWidget {
  //const Chip({Key? key}) : super(key: key);

  String title;
  String title2;
 // Widget prominent;
  String imageSource;
  final void Function() onPressed;
  String subText;
  double padding;
  double height;
  double width;
   Color titleColor;
  Color color;

  Tile({
    this.title="Title",
    this.title2 = '',
    //this.prominent,
    this.subText='',
    required this.onPressed,
    this.padding = 2.0,
    this.imageSource = '',
    this.height=100,
    this.width=100,
    this.titleColor = Colors.blueAccent,
    this.color = Colors.white});



  @override
  Widget build(BuildContext context) {


    return  Padding(
      padding:  EdgeInsets.all(this.padding.w),
      child: GestureDetector(
            onTap: this.onPressed,
            child: Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                          ),
            elevation: 5,
            color: this.color,
            child:Column(

                  children: [
                      Column(

                      children: [
                          Row(
                            children: [
                              Padding(
                                padding: DefaultValues.kDefaultPaddingAllSame(context),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(this.imageSource,
                                          height: 8.h, //* DefaultValues.adaptForSmallDevice(context),
                                          width: 8.w, //* DefaultValues.adaptForSmallDevice(context),
                                  )),
                                    ),
                              Padding(
                                padding:  EdgeInsets.only(
                                  left: 1.w,
                                  top: 1.h,
                                ) ,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    this.title,
                                    style: TextStyle(fontSize: 15.sp,
                                        color: titleColor, fontWeight: FontWeight.bold),
                                  ),
                                ),

                              ),
                            ],
                          ),


                            Padding(
                              padding: DefaultValues.kAdaptedLeftPadding(context, 18),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(this.subText, style: TextStyle(color: titleColor),)),
                    ),

                  ],
                ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0, bottom: 18.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(),
                              ),
                          ),
                        ],
                      ),
              ],
            ),




                ),
      ),


    );
  }
}
