import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';

class Shingle extends StatelessWidget {
  const Shingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:Image.asset('images/mutual.png',height: 20,width: 20,),
        title: Text('Mutual Fund',style: kH2,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invested 100 Lakh '),
            Text('Present Value 210 Lakh')
          ],
        ),

      ),
    );
  }
}
