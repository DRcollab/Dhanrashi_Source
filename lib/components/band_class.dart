
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class Band extends StatefulWidget {
//  const Band({Key? key}) : super(key: key);

String title = '';
Widget headingChild;  // first in the band
IconData buttonIcon; // normally last in the band
IconData alternateIcon; // alternate icon

String text = '';
String subText = '';
TextEditingController controller;


/// Constructor
Band({
  this.title = '',
  required this.headingChild,
  this.text='',
  this.subText='',
  this.buttonIcon = Icons.edit,
  this.alternateIcon = Icons.save,

  required this.controller});

  @override
  _BandState createState() => _BandState();
}

class _BandState extends State<Band> {


bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:1.h, horizontal:1.w),
      child: Container(
          decoration: BoxDecoration(

              color: Colors.white,
              boxShadow: [
                  BoxShadow(
                      color: kPresentTheme.shadowColor,
                      offset: Offset(0.25,0.5),
                      blurRadius: 1.0,
                      spreadRadius: .5,

                    )
                        ],// Box Shadow

          borderRadius: BorderRadius.all(Radius.circular(10)),


        ),


        child: Padding(
          padding: EdgeInsets.symmetric(vertical:1.h, horizontal:2.w),
          child: Row(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.w,top:0,right: 0, bottom: 0),
                      child: this.widget.headingChild,
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10.w,top:0,right: 0, bottom: 0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 0,top:0,right: 0, bottom: 0),
                                child: Text(this.widget.title),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0,top:0,right: 0, bottom: 0),
                                child: EditableTextField(
                                  editingController: this.widget.controller,
                                  isEditing: this.isEditing,
                                  initialText: this.widget.text,
                                  style: TextStyle(fontSize: 14.sp),),
                              ),
                              Text(this.widget.subText),

                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: this.isEditing ? Icon( this.widget.alternateIcon) : Icon( this.widget.buttonIcon),
                      onPressed: (){
                        setState(() {
                          this.isEditing = !this.isEditing;
                        });
                        //toggleBandState(this.isEditing);
                      },
                    ),

            ],
          ),

        ),

      ),
    );

  }
}
