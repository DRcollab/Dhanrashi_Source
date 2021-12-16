import 'dart:core';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dhanrashi_mvp/components/maps.dart';

class TableView extends StatefulWidget {

  List arrayList;

  TableView({
   required this.arrayList,
});

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {

  late int numItems;
  late List<DataColumn> dataColumns = List.empty(growable:true);
  late List<DataRow> dataRows= List.empty(growable:true);
  int columnCount = 0;

  @override
  void initState() {
    late List<DataCell> dataCells;
    // TODO: implement initState




    if(widget.arrayList.length>1){
      columnCount = widget.arrayList.length-1;
    }else{
      columnCount = widget.arrayList.length;
    }
    numItems = widget.arrayList[0].length;


    super.initState();

    dataColumns.add(
      DataColumn(label: SizedBox(
        child: Text('Year', style: DefaultValues.kH4(context),),
      ))
    );

    for(int i = 0; i<columnCount;i++){
    //  print(widget.arrayList[i][0]);
     dataColumns.add( DataColumn(
          label: prefixSymbols.contains(widget.arrayList[i][0].substring(0,1))
              ? Text(widget.arrayList[i][0].substring(1),style:DefaultValues.kH4(context))
              : Text(widget.arrayList[i][0], style:DefaultValues.kH4(context))
      ));
    }








    for (int i = 1; i< numItems ; i++){
      dataCells = List.empty(growable: true);
      dataCells.add(
          DataCell(
              SizedBox(

                child: Text(i.toString()),
              )
          )
      );
     for(int j = 0; j<columnCount; j++) {

       print(widget.arrayList[j][0]);


       dataCells.add(
           DataCell(
               SizedBox(
                 child: Text(widget.arrayList[j][i].toString()),
               )
           )
       );
     }
       dataRows.add(
         DataRow(
           cells: dataCells,
         )
       );

     }






  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(top: DefaultValues.screenHeight(context)<600 ?3.h:0),
          child: DataTable(

            headingRowColor: MaterialStateColor.resolveWith((states) => kPresentTheme.alternateColor),
            headingRowHeight: 6.h,
            columns: dataColumns,

            rows: dataRows,

          ),
        ),
      ),
    );
  }
}



// List<DataColumn>.generate(
// widget.arrayList.length, (int index1) {
// return  DataColumn(
// label: SizedBox(
//
// child: Text(widget.arrayList[index1][0], style: DefaultValues.kH4(context),),
// )
// );
// }
// ),



// List<DataRow>.generate(
// numItems , (int index) {
// index=1;
// return  DataRow(
// cells: List<DataCell>.generate(
// widget.arrayList.length,(int index1) =>
// DataCell(
// SizedBox(
// child: Text(widget.arrayList[index1][index].toString()),
// )
// )
// )
//
// );
// }
//
//
// ),