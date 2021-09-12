import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/components/constants.dart';

class Shingle extends StatelessWidget {
  //const Shingle({Key? key}) : super(key: key);

  String title;
  String subtitle;
  String value = '';
  String leadingImage ='';
  Widget? trailing;

  Shingle( {
    required this.title,
    required this.subtitle,
    this.value= '',
    this.leadingImage ='',
    this.trailing,
  } );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:Image.asset(this.leadingImage,height: 20,width: 20,),
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
    );
  }
}
