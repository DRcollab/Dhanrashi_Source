import 'package:dhanrashi_mvp/components/band_class.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';
import 'action_circle.dart';
import 'package:sizer/sizer.dart';

class PhotoSheet extends StatefulWidget {


  int selectedIndex = 0;

  late Function(int) getChoice;

  PhotoSheet({required this.getChoice});


  @override
  _PhotoSheetState createState() => _PhotoSheetState();
}

class _PhotoSheetState extends State<PhotoSheet> {
  @override
  Widget build(BuildContext context) {
    print(' selected:${widget.selectedIndex}');

    return Container(
      color: Color(0x00000000),
      child: Wrap(
        // shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(

            decoration: BoxDecoration(
                color: kPresentTheme.themeColor,//Color(0x00000000),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset.zero,
                    blurRadius: 0.5,
                    spreadRadius: 1,

                  )
                ]
            ),
            child: Padding(
              padding:  EdgeInsets.all(2.w),
              child: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(FontAwesomeIcons.userMd),
                    Center(child: Text('Select a avatar', style:DefaultValues.kNormal1(context),)),
                    CommandButton(
                        onPressed: (){
                          Navigator.pop(context);
                          widget.getChoice(widget.selectedIndex);
                        },

                        buttonColor: kPresentTheme.alternateColor,
                        borderRadius: BorderRadius.circular(5),
                        textColor: kPresentTheme.accentColor,
                        buttonText: 'OK',

                    ),

                  ],
                ),
              ),
            ),
          ),


          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image0.png',
                        index:0,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 0) ? 48 : 40,
                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 0;
                        });
                       // Navigator.pop(context);
                      },),
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image1.png',
                        index:1,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 1) ? 48 : 40,
                      onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 1;
                        });
                      //  Navigator.pop(context);
                      },
                      ),
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image2.png',
                        index:2,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 2) ? 48 : 40,
                      onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 2;
                        });
                       // Navigator.pop(context);
                      },
                      ),


                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image3.png',
                        index:3,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 3) ? 48 : 40,
                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 3;
                        });
                       // Navigator.pop(context);
                      },),
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image4.png',
                        index:4,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 4) ? 48 : 40,
                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 4;
                        });
                      //  Navigator.pop(context);
                      },),
                      ActionCircle(
                        imageSource: 'images/profiles/profile_image5.png',
                        index:5,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 5) ? 48 : 40,

                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 5;
                        });
                      //  Navigator.pop(context);
                      },),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionCircle(
                        imageSource: 'images/profiles/profile7.png',
                        index:6,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 6) ? 48 : 40,
                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 6;
                        });
                      //  Navigator.pop(context);
                      },),
                      ActionCircle(
                        imageSource: 'images/profiles/profile8.png',
                        index:7,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 7) ? 48 : 40,
                        onPreseed: (){
                        setState(() {
                          widget.selectedIndex = 7;
                        });
                      //  Navigator.pop(context);
                      },),
                      ActionCircle(
                        imageSource: 'images/profiles/profile6.png',
                        index:8,
                        selectedIndex: widget.selectedIndex,
                        radius: (widget.selectedIndex == 8) ? 48 : 40,
                        onPreseed: (){
                          setState(() {
                            widget.selectedIndex = 8;
                          });
                        //  Navigator.pop(context);

                      },),
                    ],
                  ),
                )

              ]
          ),






        ],
      ),
    );
  }
}
