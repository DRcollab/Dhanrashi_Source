
import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';

class Band extends StatefulWidget {
//  const Band({Key? key}) : super(key: key);

String title;
Widget headingChild;
IconData buttonIcon;
Function action;
String text;
String subText;
bool isEditing;
TextEditingController controller;

Band({this.title, this.headingChild, this.text, this.subText, this.buttonIcon, this.isEditing=false,this.action, this.controller});


//bool _isEditing = false;



  @override
  _BandState createState() => _BandState();
}



class _BandState extends State<Band> {




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          ],

          borderRadius: BorderRadius.all(Radius.circular(10)),
          //color: kPresentTheme.titleColor,

        ),


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top:0,right: 0, bottom: 0),
                child: widget.headingChild,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,top:0,right: 0, bottom: 0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 0,top:0,right: 0, bottom: 0),
                          child: Text(widget.title),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0,top:0,right: 0, bottom: 0),
                          child: EditableTextField(
                            editingController: widget.controller,
                            isEditing: widget.isEditing,
                            initialText: widget.text,
                          style: TextStyle(fontSize: 18),),
                        ),
                        Text(widget.subText),

                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  widget.buttonIcon,
                ),
                onPressed: (){
                  setState(() {
                    widget.isEditing = true;
                     widget.action();
                  });
                },
              ),

            ],
          ),

        ),

      ),
    );

  }
}
