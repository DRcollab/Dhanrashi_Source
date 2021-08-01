import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';


class Tile extends StatelessWidget {
  //const Chip({Key? key}) : super(key: key);

  String title;
  Widget prominent;
  String imageSource;
  Function onPresed;
  String subText;
  double padding;
  double height;
  double width;
  Color titleColor;

  Tile({this.title="Title", this.prominent,  this.subText,this.onPresed, this.padding=8.0, this.imageSource, this.height=100, this.width=100});



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(this.padding),
      child: Card(

          elevation: 1,
          color: kPresentTheme.cardColors[1],
          child:Column(

            children: [
              Container(
                  color: kPresentTheme.accentButtonColor,
                  child: Text(
                    this.title,
                    style: TextStyle(fontSize: 20,color: kPresentTheme.lightTextColor),
                  ),
              ),
              Image.asset(this.imageSource,
              height: this.height, width: this.width,),
            ],
          ),



              ),


    );
  }
}
