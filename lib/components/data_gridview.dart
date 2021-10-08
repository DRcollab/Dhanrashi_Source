import 'package:flutter/material.dart';

class DataRow extends StatefulWidget {
  const DataRow({Key? key}) : super(key: key);

  @override
  _DataRowState createState() => _DataRowState();
}

class _DataRowState extends State<DataRow> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Colum1'),
        Text('Column2'),
      ],

      scrollDirection: Axis.horizontal,
    );
  }
}
