


class Investment {
  Investment(
      {
        this.userId,
        this.name,
        this.currentInvestmentAmount,
        this.annualInvestmentAmount,
        this.investmentRoi,
        this.investmentDuration});

  final String userId;
  final String name;
  final double currentInvestmentAmount;
  final double annualInvestmentAmount;
  final double investmentRoi;
  final double investmentDuration; //int or double??
}