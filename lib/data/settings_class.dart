import 'package:dhanrashi_mvp/components/theme_class.dart';
import 'package:dhanrashi_mvp/constants.dart';

class Settings {

  String profilePic = '';
  DhanrashiTheme theme = kPresentTheme;
  String currency = 'INR';
  String numberFormat = 'Lakh';


  Settings(this.profilePic, this.theme, this.currency, this.numberFormat);

  Settings.fromJSON(Map<String, dynamic> json ){
    profilePic = json['profilePic'];
    theme = json['theme'];
    currency = json['currency'];
    numberFormat = json[numberFormat];

  }


 Map<String, dynamic> toJSON() => {
    'profilePic':profilePic,
    'theme':theme,
    'currency' : currency,
    'numberFormat': numberFormat,

  };



}