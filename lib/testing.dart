import 'package:dhanrashi_mvp/components/band_class.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/custom_text_field.dart';
import 'package:flutter/material.dart';



class Tester extends StatelessWidget {
  //const Tester({Key? key}) : super(key: key);

  TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Row(
            children: [
              EditableTextField(
                style: TextStyle(fontSize: 20),
                editingController: ctrl,),
              IconButton(onPressed: (){}, icon: Icon(Icons.height)),
            ],
          )
        ),
    );
  }
}
