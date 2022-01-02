import 'dart:core';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:dhanrashi_mvp/components/maps.dart';

class TableView extends StatefulWidget {

  List arrayList;
  String firstColumn;
  bool useFirstColumnFromList = false;

  TableView({
   required this.arrayList,
    this.firstColumn = 'Year',
    this.useFirstColumnFromList = false,
});

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {

  late int numItems;
  late List<DataColumn> dataColumns = List.empty(growable:true);
  late List<DataRow> dataRows= List.empty(growable:true);
  int columnCount = 0;
  int startingPoint = 0;
  String firstColumn = '';

  @override
  void initState() {
    late List<DataCell> dataCells;
    // TODO: implement initState



    if(widget.arrayList.length>1) {
      if (!widget.useFirstColumnFromList) {
        columnCount = widget.arrayList.length - 1;
        startingPoint = 0;
      }else {
        columnCount = widget.arrayList.length;
        startingPoint = 1;
      }
    }



    numItems = widget.arrayList[0].length;

    //widget.firstColumn must not be null if useDeaultColumn is true
    if(!widget.useFirstColumnFromList){
      dataColumns.add(
          DataColumn(label: SizedBox(
            child: Text(widget.firstColumn, style: DefaultValues.kH4(context),),
          ))
      );

    }



    super.initState();


    for(int i = 0; i<columnCount;i++){
    //  print(widget.arrayList[i][0]);

     dataColumns.add( DataColumn(
          label: prefixSymbols.contains(widget.arrayList[i][0].substring(0,1))
              ? Text(widget.arrayList[i][0].substring(1),style:DefaultValues.kH4(context))
              : Text(widget.arrayList[i][0], style:DefaultValues.kH4(context))
      ));
    }







   // if(!widget.useFirstColumnFromList){
    for (int i = 1; i< numItems ; i++){
      dataCells = List.empty(growable: true);
      dataCells.add(
          DataCell(
              SizedBox(

                child: !widget.useFirstColumnFromList ? Text(i.toString()) : Text(widget.arrayList[0][i]),
              )
          )
      );
     for(int j = startingPoint; j<columnCount; j++) {


       double value = double.parse(widget.arrayList[j][i]);

       dataCells.add(
           DataCell(
               SizedBox(
                 child: Text(DefaultValues.financialFormat(DefaultValues.textFormatWithDecimal, value)),
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

