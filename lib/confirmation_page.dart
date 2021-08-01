
import 'dart:ffi';

import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/profiler.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/band_class.dart';
import 'data/user_data_class.dart';
import 'components/buttons.dart';
import 'data/user_handler.dart';
import 'data/database.dart';


class ConfirmationPage extends StatefulWidget {
  // const ConfirmationPage({Key? key}) : super(key: key);

  Collector collector;
  UserData currentUser = UserData(null,null,null,null,null);


  ConfirmationPage({this.collector, this.currentUser}){
    collector = Collector();
  }

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}


class _ConfirmationPageState extends State<ConfirmationPage> {

  bool _isEditing = false;
  var _userHandler = UserHandeler(userTable, userProfileTable);

  @override
  void initState() {
    // TODO: implement initState
    Collector profileCollector = widget.collector;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.collector.dateOfBirth);
    print(widget.collector);
    print(widget.collector.dateOfBirth);

    return CustomScaffold(
      child: Container(

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,

            children : [

              Image.asset('images/confirmed.png',
                height: 200,
                width: 200,

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Confirm your entries", style: kH1,),
              ),
              Column(
                children: [
                  Band(
                    headingChild: Icon(Icons.drive_file_rename_outline, color: kPresentTheme.navigationColor,),
                    title: "Name",
                    text: profileCollector.fName.text,
                    subText: "",
                    controller: profileCollector.fName,
                    buttonIcon:  !_isEditing ? Icons.edit : Icons.subdirectory_arrow_right,
                    isEditing: _isEditing,

                    action:(){

                      setState(() {
                        print(profileCollector.fName.text);
                        _isEditing = !_isEditing;
                      });

                    },

                  ),
                  Band(
                    headingChild: Icon(Icons.drive_file_rename_outline,color: kPresentTheme.navigationColor),
                    title: "Last Name",
                    text: profileCollector.lName.text,
                    controller: profileCollector.lName,
                    subText: "",
                    buttonIcon:  !_isEditing ? Icons.edit : Icons.subdirectory_arrow_right,
                    isEditing: _isEditing,

                    action:(){

                      setState(() {
                        print(profileCollector.fName.text);
                        _isEditing = !_isEditing;
                      });

                    },
                  ),

                  Band(
                    headingChild: Icon(Icons.drive_file_rename_outline,color: kPresentTheme.navigationColor),
                    title: "Date of Birth",
                    text: '${profileCollector.dateOfBirth.day}/${profileCollector.dateOfBirth.month}/${profileCollector.dateOfBirth.year}',


                    subText: "age",
                    buttonIcon:  !_isEditing ? Icons.edit : Icons.subdirectory_arrow_right,
                    isEditing: _isEditing,

                    action:(){

                      setState(() {
                        print(profileCollector.fName.text);
                        _isEditing = !_isEditing;
                      });

                    },
                  ),
                  Band(
                    headingChild: Icon(Icons.drive_file_rename_outline, color: kPresentTheme.navigationColor),
                    title: "Annual Income",
                    text:  profileCollector.annualIncome.toString(),
                    subText: "",
                    buttonIcon:  !_isEditing ? Icons.edit : Icons.subdirectory_arrow_right,
                    isEditing: _isEditing,

                    action:(){

                      setState(() {
                        print(profileCollector.fName.text);
                        _isEditing = !_isEditing;
                      });

                    },
                  ),

                ],
              ),

          Padding(
            padding: const EdgeInsets.only(left:18.0, right: 18.0, top: 8.0,),
            child: CommandButton(

              borderRadius: BorderRadius.circular(20),
              buttonText: "Add User Details",
              buttonColor: kPresentTheme.accentButtonColor,

              onPressed:(){

                /// on pressing this button data will be saved in database ...
                setState(() {

                  print(widget.currentUser.eMail());

                  widget.currentUser.setFName(profileCollector.fName.text); /// calling User data methods -- open user_data_class.dart file
                  widget.currentUser.setLName(profileCollector.lName.text);/// calling User data methods -- open user_data_class.dart file
                  widget.currentUser.setIncome(profileCollector.annualIncome.toString());/// calling User data methods -- open user_data_class.dart file
                  widget.currentUser.setDOB(profileCollector.dateAsString());/// calling User data methods -- open user_data_class.dart file

                  _userHandler.createUser(widget.currentUser); /// creating user from currentUser data -- open usr_handler.dart

                  _userHandler.addProfile();  /// adding user profile to the database -- mock database [UserPtofileTable]


                  _userHandler.printUserData();
                });

              },
            ),
          )

            ]
        ),



      ),
    );
  }
}