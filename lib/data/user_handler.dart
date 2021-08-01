




import 'package:dhanrashi_mvp/data/user_data_class.dart';

import 'database.dart';



class UserHandeler{

  var userTable = [[]];
  List<UserData> profileTable = [];


  UserData _user = new UserData(null, null, null, null, null);

  UserHandeler(List<List> source, List<UserData> profile){

    userTable = source;
    profileTable = profile;



  }

  void add(List<String> data){

    userTable.add(data);

  }

  void printTable(){
    print(userTable);
    print(profileTable);

  }

  void createUser(UserData user ){

    this._user = user;

  }

  void addProfile(){

    print("~~~~~~~~~~~~~~~~");
    print(_user.firstName());
    profileTable.add(_user);

  }

  bool authenticateUser(String userId , String pwd) {

        for (List row in userTable){
          if(row.contains(userId)){
            if(row[1].toString() == pwd){
              print(" ------- $userId");
              this._user.setEmail(userId);
              return true;
            }
          }

        }
        return false;

  }



  bool fetchProfile(){

    int len;

    print("in fetch profile");

    for(UserData row in profileTable){

      if(row.contains(this._user.eMail())){
        print("email validate");
        this._user = row;

        return true;
      }

    }

    return false;
  }



 UserData user(){

    return _user;
 }

 void printUserData(){


    print('_____________________');
    print('Name: ${_user.firstName()}');
    print('last Name: ${_user.lastName()}');
    print('eMail:${_user.eMail()}');
    print('DOB: ${_user.dob()}');
    print('Income :${_user.income()}');



 }

}


