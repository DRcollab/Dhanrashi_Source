import 'package:dhanrashi_mvp/models/investment.dart';
import 'dart:math';
import 'package:matrix2d/matrix2d.dart';
import 'package:dhanrashi_mvp/models/goal.dart';
//import 'package:finance/finance.dart';

class Calculator {
  List<Investment> _investmentPortfolio = [
    Investment(
        name: 'Cash',
        currentInvestmentAmount: 10,
        annualInvestmentAmount: 2,
        investmentRoi: .04,
        duration: 10),
    Investment(
        name: 'Equity',
        currentInvestmentAmount: 20,
        annualInvestmentAmount: 7,
        investmentRoi: .12,
        duration: 15),
    Investment(
        name: 'PF',
        currentInvestmentAmount: 10,
        annualInvestmentAmount: 2,
        investmentRoi: .085,
        duration: 20),
  ];

  List<Goal> _goalList = [
    Goal(
      name: 'Home',
      description: 'Home Fund',
      goalAmount: 10,
      duration: 2,
      inflation: 0.04,
    ),
    Goal(
      name: 'Education',
      description: 'Need cash for Education',
      goalAmount: 70,
      duration: 8,
      inflation: 0.04,
    ),
    Goal(
      name: 'Retirement',
      description: 'Retirement Fund',
      goalAmount: 200,
      duration: 20,
      inflation: 0.04,
    ),
    Goal(
      name: 'Secret',
      description: 'Retirement Fund',
      goalAmount: 100,
      duration: 10,
      inflation: 0.04,
    ),
  ];

  int longestInvestmentDuration = 0,
      longestGoalDuration = 0,
      longestDuration = 0;

  double fv(double r, int nper, double pmt, double pv, int type) {
    double fv = (pv * pow(1 + r, nper) +
        pmt * (1 + r * type) * (pow(1 + r, nper) - 1) / r);
    return fv;
  }

  double sipAmount(double r, int nper, double pv, double fv, int type) {
    double pmt = (fv - pv * pow(1 + r, nper)) /
        ((1 + r * type) * (pow(1 + r, nper) - 1) / r);
    return pmt;
  }

  // TODO exception handling

  int getLongestInvestmentDuration(List<Investment> list) {
    int investmentDuration = 0;
    for (int i = 0; i < list.length; i++) {
      Investment newInv = list[i];

      if (newInv.duration > investmentDuration) {
        investmentDuration = newInv.duration;
      }
    }
    return investmentDuration;
  }

  int getLongestGoalDuration(List<Goal> list) {
    int goalDuration = 0;
    for (int i = 0; i < list.length; i++) {
      Goal newGoal = list[i];

      if (newGoal.duration > goalDuration) {
        goalDuration = newGoal.duration;
      }
    }
    return goalDuration;
  }

  // TODO : need to find out the longest duration among the investment and goals
  // based on that populate the investment and goals

  List getInvestmentDetail() {
    longestInvestmentDuration =
        getLongestInvestmentDuration(_investmentPortfolio);
    longestGoalDuration = getLongestGoalDuration(_goalList);

    print('longestInvestmentDuration = $longestInvestmentDuration');
    print('longestGoalDuration = $longestGoalDuration');

    List allInvestmentAnnualAmt = List.empty(growable: true);

    double futureValue = 0;

    for (int i = 0; i < _investmentPortfolio.length; i++) {
      Investment newInv = _investmentPortfolio[i];
      print(newInv.name);

      List investmentAnnualAmt = List.empty(growable: true);
      investmentAnnualAmt.add(newInv.name);
      //for (int j = 0; j < newInv.investmentDuration; j++) {
      for (int j = 0; j < longestInvestmentDuration; j++) {
        // TODO: Need to fix the calculation error for cash at 11th Year
        if (j < newInv.duration) {
          futureValue = fv(newInv.investmentRoi, j + 1,
              newInv.annualInvestmentAmount, newInv.currentInvestmentAmount, 0);
          // } else {
          //   futureValue = futureValue * (1 + newInv.investmentRoi);
        } else {
          futureValue = futureValue;
        }

        investmentAnnualAmt.add(futureValue.toStringAsFixed(2));
      }
      allInvestmentAnnualAmt.add(investmentAnnualAmt);
    }

    print(allInvestmentAnnualAmt.shape);

    final shape = allInvestmentAnnualAmt.shape;

    //Adding the 'Total' column as a row
    List<dynamic> invstTotal = List.empty(growable: true);
    invstTotal.add('Total');

    //Trying to add the 'Total' column and add the columns accordingly to get
    // the Total value for each year
    for (var i = 1; i < shape[1]; i++) {
      dynamic tempValue = 0;
      for (var j = 0; j < shape[0]; j++) {
        //temp[i][j] = allInvestmentAnnualAmt[j][i];
        //tempValue += double.parse(temp[i][j]);
        tempValue += double.parse(allInvestmentAnnualAmt[j][i]);
      }
      //print('added by year: $tempValue');
      invstTotal.add(tempValue.toStringAsFixed(2));
    }

    allInvestmentAnnualAmt.add(invstTotal);

    //print(allInvestmentAnnualAmt);
    //Add the 'Year' column
    List<dynamic> invstYear = List.empty(growable: true);
    invstYear.add('Year');
    //Populate the year to the column
    for (int i = 1; i <= longestInvestmentDuration; i++) {
      invstYear.add(i);
    }

    allInvestmentAnnualAmt.add(invstYear);
    print(allInvestmentAnnualAmt);
    print(allInvestmentAnnualAmt.shape);

    return allInvestmentAnnualAmt;
  }

  List getGoalDetail() {
    longestInvestmentDuration =
        getLongestInvestmentDuration(_investmentPortfolio);
    longestGoalDuration = getLongestGoalDuration(_goalList);

    print('InGetgoalDetail()');
    print('longestInvestmentDuration = $longestInvestmentDuration');
    print('longestGoalDuration = $longestGoalDuration');

    List allGoalAnnualAmt = List.empty(growable: true);

    double yearEndAmount = 0;

    for (int i = 0; i < _goalList.length; i++) {
      Goal newGoal = _goalList[i];
      print(newGoal.name);

      List goalAnnualAmt = List.empty(growable: true);
      goalAnnualAmt.add(newGoal.name);
      //for (int j = 0; j < newInv.investmentDuration; j++) {
      for (int j = 0; j < longestGoalDuration; j++) {
        if (j + 1 == newGoal.duration) {
          yearEndAmount = newGoal.goalAmount;
        } else if (j + 1 > newGoal.duration) {
          yearEndAmount = yearEndAmount * (1 + newGoal.inflation);
        } else {
          yearEndAmount = 0;
        }
        goalAnnualAmt.add(yearEndAmount.toStringAsFixed(2));
      }

      allGoalAnnualAmt.add(goalAnnualAmt);
    }

    print(allGoalAnnualAmt.shape);

    final shape = allGoalAnnualAmt.shape;

    //Adding the 'Total' column as a row
    List<dynamic> goalsTotal = List.empty(growable: true);
    goalsTotal.add('Total');

    //Trying to add the 'Total' column and add the columns accordingly to get
    // the Total value for each year
    for (var i = 1; i < shape[1]; i++) {
      dynamic tempValue = 0;
      for (var j = 0; j < shape[0]; j++) {
        tempValue += double.parse(allGoalAnnualAmt[j][i]);
      }
      goalsTotal.add(tempValue.toStringAsFixed(2));
    }

    allGoalAnnualAmt.add(goalsTotal);

    //Add the 'Year' column
    List<dynamic> goalYear = List.empty(growable: true);
    goalYear.add('Year');
    //Populate the year to the column
    for (int i = 1; i <= longestGoalDuration; i++) {
      goalYear.add(i);
    }

    allGoalAnnualAmt.add(goalYear);
    print(allGoalAnnualAmt);
    print(allGoalAnnualAmt.shape);

    return allGoalAnnualAmt;
  }

  List getInvVsGoalDetail() {
    longestInvestmentDuration =
        getLongestInvestmentDuration(_investmentPortfolio);
    longestGoalDuration = getLongestGoalDuration(_goalList);

    print('In getInvVsGoalDetail()');
    print('longestInvestmentDuration = $longestInvestmentDuration');
    print('longestGoalDuration = $longestGoalDuration');

    List allGoalAnnualAmt = getGoalDetail();
    List allInvestmentAnnualAmt = getInvestmentDetail();
    List investmenetVsGgoal = List.empty(growable: true);

    if (allInvestmentAnnualAmt.isNotEmpty) {
      investmenetVsGgoal
          .add(allInvestmentAnnualAmt[allInvestmentAnnualAmt.shape[0] - 2]);
    }
    if (allGoalAnnualAmt.isNotEmpty) {
      investmenetVsGgoal.add(allGoalAnnualAmt[allGoalAnnualAmt.shape[0] - 2]);
      investmenetVsGgoal.add(allGoalAnnualAmt[allGoalAnnualAmt.shape[0] - 1]);
    }

    print(investmenetVsGgoal.shape);
    print(investmenetVsGgoal);

    return investmenetVsGgoal;
  }
}
