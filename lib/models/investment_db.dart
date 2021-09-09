/// This code is written by Arvind Ganesan  part of Dhanrashi_MVP project
import 'package:dhanrashi_mvp/models/investment.dart';


class InvestDB{

  InvestDB({
    required String email,
     String? investmentDocumentID ,
    required String userID,
    required Investment investment,
    // this.name,
    // this.currentInvestmentAmount,
    // this.annualInvestmentAmount,
    // this.investmentRoi,
    // this.investmentDuration

  }
      ){
    this._email = email;
    this._investmentDocumentID = investmentDocumentID!;
    this._userID = userID;
    this._investment = investment;

  }


  late String _userID;
  late String _email ;
  late String _investmentDocumentID;
  // String name;
  // double currentInvestmentAmount;
  // double annualInvestmentAmount;
  // double investmentRoi;
  // double investmentDuration;

  late Investment _investment;

  String get email => this._email;
  String get investmentId => this._investmentDocumentID;
  String get userId => this._userID ;
  Investment get investment => this._investment ;


   set email(email) => this._email = email;
   set investmentId(investmentId) => this._investmentDocumentID = investmentId;
  set userId(userId) => this._userID = userId;
  set investment(investment) => this._investment = investment;

}