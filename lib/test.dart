import 'components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/custom_card.dart';

class Tester extends StatelessWidget {
  //const Tester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InputCard(
      titleText: 'Hello',
      children: [CupertinoDatePicker(onDateTimeChanged: (dateValue) {})],
    ));
  }
}
