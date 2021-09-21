import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';


class Tile extends StatelessWidget {
  //const Chip({Key? key}) : super(key: key);

  String title;
 // Widget prominent;
  String imageSource;
  final void Function() onPressed;
  String subText;
  double padding;
  double height;
  double width;
   Color titleColor;
  Color color;

  Tile({this.title="Title",
    //this.prominent,
    this.subText='',
    required this.onPressed,
    this.padding=8.0,
    this.imageSource = '',
    this.height=100,
    this.width=100,
    this.titleColor = Colors.blueAccent,
    this.color = Colors.white});



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(this.padding),
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
                          Padding(
                            padding: DefaultValues.kDefaultPaddingAllSame(context),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(this.imageSource,
                                      height: 50 * DefaultValues.adaptForSmallDevice(context),
                                      width: 50 * DefaultValues.adaptForSmallDevice(context),
                              )),
                                ),
                          Padding(
                            padding:  EdgeInsets.only(
                                        left: 18.0 * DefaultValues.adaptForSmallDevice(context),
                                        top:8.0 * DefaultValues.adaptForSmallDevice(context),
                            ) ,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  this.title,
                                  style: TextStyle(fontSize: 20 * DefaultValues.adaptFontsForSmallDevice(context),
                                            color: titleColor, fontWeight: FontWeight.bold),
                        ),
                      ),

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
                                child: Icon(Icons.style,
                                  size: 20 * DefaultValues.adaptFontsForSmallDevice(context),
                                )),
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
