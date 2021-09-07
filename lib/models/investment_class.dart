


class Investment {
  Investment(


        this._name,
        this._currentInvestmentAmount,
        this._annualInvestmentAmount,
        this._investmentRoi,
        this._investmentDuration);


   Investment.create(){
     this._name = '';
     this._currentInvestmentAmount = 0;
     this._annualInvestmentAmount = 0;
     this._investmentRoi = 0.0;
     this._investmentDuration = 0;
   }


   String _name = '';
   double _currentInvestmentAmount = 0;
   double _annualInvestmentAmount = 0;
   double _investmentRoi = 0;
   double _investmentDuration = 0; //int or double??

String get name{
  return _name;
}

double get currentInvestmentAmount{
   return _currentInvestmentAmount;
}

double get annualInvestmentAmount{
  return _annualInvestmentAmount;
}

double get investmentRoi{
    return _investmentRoi;
}

double get investmentDuration{

  return _investmentDuration;
}


void set name(String name){
  _name = name;
}

void set currentInvestmentAmount(double inv){

  _currentInvestmentAmount = inv;
}


void set annualInvestmentAmount(double inv){

  _annualInvestmentAmount = inv;
}

void set investmentRoi(double rate){

  _investmentRoi = rate;

}

}

