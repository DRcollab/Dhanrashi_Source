import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'components/custom_text_field.dart';


class Tester extends StatefulWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {

  late TextEditingController txt = TextEditingController();

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          NumberInputField(
              controller: TextEditingController())
        ],
      ),
    );
  }
}
