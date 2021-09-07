/// written by Debashis Chakroborty


class Investment {
  Investment(
      {required this.name,
      required this.currentInvestmentAmount,
      required this.annualInvestmentAmount,
      required this.investmentRoi,
      required this.duration});

  final String name;
  final double currentInvestmentAmount;
  final double annualInvestmentAmount;
  final double investmentRoi;
  final int duration; //int or double??

}


