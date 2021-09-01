/// This code is written by Arvind Ganesan  part of Dhanrashi_MVP project

class InvestDB{
  InvestDB(
      this.email,
      this.investmentDocumentID,
      this.userID,
      this.name,
      this.currentInvestmentAmount,
      this.annualInvestmentAmount,
      this.investmentRoi,
      this.investmentDuration);
  String userID;
  String email;
  String investmentDocumentID;
  String name;
  double currentInvestmentAmount;
  double annualInvestmentAmount;
  double investmentRoi;
  double investmentDuration;
}