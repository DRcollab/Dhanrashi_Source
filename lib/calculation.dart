import 'models/investment_class.dart';
import 'dart:math';
import 'package:matrix2d/matrix2d.dart';

class Calculator {
  List<Investment> _investmentPortfolio = [
    Investment(
         'Cash',
         10,
         2,
        .04,
        10),
    Investment(
        'Equity',
         20,
         7,
         .12,
         15),
  //   Investment(
  //       name: 'PF',
  //       currentInvestmentAmount: 10,
  //       annualInvestmentAmount: 2,
  //       investmentRoi: .085,
  //       investmentDuration: 18),
   ];
  double longestInvestmentDuration = 0;

  List getInvestmentDetail() {
    for (int i = 0; i < _investmentPortfolio.length; i++) {
      Investment newInv = _investmentPortfolio[i];
      //print(newInv.name);

      if (newInv.investmentDuration > longestInvestmentDuration) {
        longestInvestmentDuration = newInv.investmentDuration;
      }
    }

    print('longestInvestmentDuration = $longestInvestmentDuration');

    List allInvestmentAnnualAmt = List.empty(growable: true);

    for (int i = 0; i < _investmentPortfolio.length; i++) {
      Investment newInv = _investmentPortfolio[i];
      //print(newInv.name);

      List invstmentAnnualAmt = List.empty(growable: true);
      invstmentAnnualAmt.add(newInv.name);
      //for (int j = 0; j < newInv.investmentDuration; j++) {
      for (int j = 0; j < longestInvestmentDuration; j++) {
        var yearEndAmount = newInv.currentInvestmentAmount *
            pow((1 + newInv.investmentRoi), (j + 1)) +
            (j < newInv.investmentDuration ? newInv.annualInvestmentAmount : 0);

        invstmentAnnualAmt.add(yearEndAmount.toStringAsFixed(2));
      }
      //print(invstmentAnnualAmt);
      //print(invstmentAnnualAmt.transpose);
      allInvestmentAnnualAmt.add(invstmentAnnualAmt);
    }
    //print(allInvestmentAnnualAmt);
    print(allInvestmentAnnualAmt.shape);

    final shape = allInvestmentAnnualAmt.shape;

    print('All good till here');

    //Transpose the 3 Rows X cols into 3 cols X rows
    var temp = List.filled(shape[1], '0')
        .map((e) => List.filled(shape[0], '0'))
        .toList();

    for (var i = 0; i < shape[1]; i++) {
      for (var j = 0; j < shape[0]; j++) {
        temp[i][j] = allInvestmentAnnualAmt[j][i];
      }
    }
    // print(temp);
    // print(temp.shape);

    //Adding the 'Total' column as a row
    List<dynamic> invstTotal = List.empty(growable: true);
    invstTotal.add('Total');

    //Trying to add the 'Total' column and add the columns accordingly to get
    // the Total value for each year
    for (var i = 1; i < shape[1]; i++) {
      dynamic tempValue = 0;
      for (var j = 0; j < shape[0]; j++) {
        //temp[i][j] = allInvestmentAnnualAmt[j][i];
        tempValue += double.parse(temp[i][j]);
      }
      //print('added by year: $tempValue');
      invstTotal.add(tempValue.toStringAsFixed(2));
    }

    print('ListTolat: $invstTotal');

    allInvestmentAnnualAmt.add(invstTotal);

    //print(allInvestmentAnnualAmt);
    //Add the 'Year' column
    List<dynamic> invstYear = List.empty(growable: true);
    invstYear.add('Year');
    //Populate the year to the column
    for (int i = 1; i <= longestInvestmentDuration; i++) {
      invstYear.add(i);
    }
    print('Listyear : $invstYear');
    allInvestmentAnnualAmt.add(invstYear);
    print(allInvestmentAnnualAmt);

    //Transpose the 5 rows ,X columns into 5 columns , X rows
    final newShape = allInvestmentAnnualAmt.shape;

    var temp1 = List.filled(newShape[1], '0')
        .map((e) => List.filled(newShape[0], '0'))
        .toList();

    for (var i = 0; i < newShape[1]; i++) {
      for (var j = 0; j < newShape[0]; j++) {
        temp1[i][j] = allInvestmentAnnualAmt[j][i].toString();
        //print(allInvestmentAnnualAmt[j][i]);
      }
    }
    print(temp1);
    print(temp1.shape);

    return allInvestmentAnnualAmt;
  }
}