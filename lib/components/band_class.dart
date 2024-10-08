import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class Band extends StatefulWidget {
//  const Band({Key? key}) : super(key: key);

  String title = '';
  Widget? headingChild; // first in the band
  IconData buttonIcon; // normally last in the band
  IconData alternateIcon; // alternate icon
  TextStyle textStyle;
  String text = '';
  String subText = '';
  TextEditingController controller;
  late Function()? onTap;
  late Function() onCommit;

  /// Constructor
  Band({
    this.title = '',
    this.headingChild,
    this.text = '',
    this.subText = '',
    this.buttonIcon = Icons.edit,
    this.alternateIcon = Icons.done,
    required this.textStyle,
    required this.controller,
    this.onTap,
    required this.onCommit,
  });

  @override
  _BandState createState() => _BandState();
}

class _BandState extends State<Band> {
  @override
  initState() {
    super.initState();
    widget.controller.text = widget.text;
  }

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //   this.widget.headingChild!=null ? Padding(
          //   padding: EdgeInsets.only(left: 0.w,top:0,right: 0, bottom: 0),
          //   child:  this.widget.headingChild,
          // ):SizedBox(width:0, height:0),
          EditableTextField(
            onTap: widget.onTap,
            editingController: this.widget.controller,
            isEditing: this.isEditing,
            initialText: this.widget.controller.text,
            style: widget.textStyle,
          ),

          this.isEditing
              ? IconButton(
                  icon: Icon(this.widget.alternateIcon),
                  onPressed: () {
                    setState(() {
                      this.isEditing = false;
                      this.widget.text = widget.controller.text;

                      widget.onCommit();
                    });
                    //toggleBandState(this.isEditing);
                  },
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isEditing = true;
                    });
                  },
                  icon: Icon(this.widget.buttonIcon),
                ),
        ],
      ),
    );
  }
}
