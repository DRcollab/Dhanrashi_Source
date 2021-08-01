

import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'components/custom_text_field.dart';
import 'components/buttons.dart';
import 'data/user_data_class.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'confirmation_page.dart';
import 'components/band_class.dart';  // confirmation page contains band class objects
import 'package:dhanrashi_mvp/data/database.dart';
import 'package:dhanrashi_mvp/data/user_handler.dart';
import 'package:dhanrashi_mvp/data/validators.dart';



/// Used to collect data from different screen of the profiler page and compile the data
class Collector{


  DateTime _dateOfBirth;
  double _annualIncome ;
  var  _fName ;
  var _lName;

/// Constructor of  the class

  Collector(){

      _dateOfBirth = null;
     _annualIncome = 0;
     _fName = TextEditingController();
     _lName = TextEditingController();



  }

  /// setter of first Name

  set fName(TextEditingController txt){

      _fName = txt;
  }

  /// setter of Lastname
  set lName(TextEditingController txt){

    _lName = txt;
  }

  /// setter of DOB
  set dateOfBirth(DateTime dt){

     _dateOfBirth = dt;
  }


  /// setter of Annual Income
  set annualIncome(double income){

    _annualIncome = income;

  }


  /// getter of firstname
 TextEditingController get fName{

    return _fName;
  }

  /// getter of Lastname
  TextEditingController get lName{

   return _lName;
  }


/// getter of DOB
 DateTime get dateOfBirth{

    return _dateOfBirth;
  }

/// getter of Income
 double get annualIncome{

    return _annualIncome;

  }

  String dateAsString(){

      return '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}';
  }

  }

  /// instance of Collector to be used in collecting user data.
var profileCollector = Collector();


/// Not for here
double scaleSmallDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  // For tiny devices.
  if (size.height < 600) {
    return 0.6;
  }
  // For normal devices.
  return 1.0;
}


/// Start of Profiler Page
/// This Widget class will take the profile details of the User
class ProfilerPage extends StatefulWidget {

/// Used to store if user wants to give details or not.
  var readyToGiveDetails = false;


/// used as named attribute to get the user data from the login page.
  UserData currentUser = UserData(null,null,null,null,null);


/// Constructor for Profile Page
  ProfilerPage({this.currentUser});


  @override
  _ProfilerPageState createState() => _ProfilerPageState();
}

/// State class of Profile page

class _ProfilerPageState extends State<ProfilerPage> {

  int index = 0; /// Used to iterate to different su screen


  var _userHandler = UserHandeler(userTable, userProfileTable); /// used  to  handle user activity like saving and retrieving data


  bool viewNavigationButton = true; /// used to hold comdition to show save button or navigator button





///  Holds the different screen header display .
  final List<String> headers = [
    "Great, Let's start with your name",
    'Your age factors how  you choose your investments.',
    'Declaration of your Income will help us recommend you financial product',
    ''
  ];

  /// Holds the necessary desscription .. THIS NEED TO BE REVIEWED
  final List<String> description = [

    'Your name would be used to customize this app for you',
    '',
    '',
  ];

  /// LIST ENDS HERE

@override
  void initState() {

    super.initState();
  }







  final List<Widget> CardChoice = [



    NamePicker(), /// THIS IS THE SCREEN TO COLLECT NAME AND LASTNAME

    DOBPicker( ), /// THIS SHOWS CALENDER DISPLAY AND COLLECT DOB

    IncomePicker(), /// THIS SHOWS THE RADIO OPTIONS TO COLLECT INCOME RANGE
    ///
   // ConfirmationPage(),/// THIS SHOWS THE ENTERED INFO FOR CONFIRMATION
  ];




  @override
  Widget build(BuildContext context) {


    /// toggles the view of save button and navigation button
    ///
    Widget navButton = NavigationButtonSet(   ///
      spaceBetween: 20,
      leftButtonText: "Back",
      rightButtonText: "Next",

      textColor: kDarkTextColor,
      rightButtonPressed: () {
        // responds when right navigation button pressed

        print(index);
        setState(() {
          index++;
          if (index < 2) {

            viewNavigationButton = true;
          }
          else{

            viewNavigationButton = false;

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmationPage(collector: profileCollector,)));
          }
        },
        );
      },
      leftButtonPressed: () {
        // Responds when left navigation button pressed
        setState(() {
          if (index>=0) {

            index--;
            viewNavigationButton = true;
          }
        },
        );
      },
    );  /// Navigation button



/// holds the different screens for collecting user data///
    ///




    //Widget comButt =  /// Command Button


    return CustomScaffold(
      child: Container(
       // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left:18, top:28),
                child: Text(

                  headers[index],
                  style: TextStyle(
                    color: kPresentTheme.inputTextColor,
                    fontSize: 24.0 * scaleSmallDevice(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            CardChoice[index],
            Expanded(
              flex: 2,
              child: Center(
                child: viewNavigationButton ? navButton : navButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// End of ProfilerPage Class..........
///

/// name picker is component in profiler page class

class NamePicker extends StatefulWidget {
  //const Names({Key? key}) : super(key: key);

  var fname = TextEditingController();
  var lname = TextEditingController();

  NamePicker({this.fname, this.lname});



  @override
  _NamePickerState createState() => _NamePickerState();
}

class _NamePickerState extends State<NamePicker> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(top:28,left: 8,right: 8,bottom: 8),
        child: InputCard(
              titleText: "Name and Lastname",
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  Padding(
                    padding: EdgeInsets.only(left: 18, top: 4, right: 18, bottom: 10),
                     child: Text(
              '           Your name would be used to customize this app for you',
                            style: TextStyle(
                            fontSize: 20.0,
                            color: kPresentTheme.darkTextColor
                               )       ,
                        ),
                    ),
                  SizedBox(height: 30,),
                  Padding(
                      padding: kTextFieldPadding,
                          child: CustomTextField(
                                icon: Icons.badge,
                                controller:  profileCollector.fName,
                                hintText: 'First Name',
                                ),
                        ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 28.0, 18.0, 48.0),
                      child: CustomTextField(
                          icon: Icons.badge,
                          controller: profileCollector.lName,
                          hintText: 'Last Name',
                    ),
                  ),

        ],
      ),
    );
  }
}


class DOBPicker extends StatefulWidget {
 // const DOBPicker({Key? key}) : super(key: key);

  String datePicker;

  DOBPicker({this.datePicker});

  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, left:8, right: 8),
      child: GradientCard(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left:8,top:16,bottom: 0,right:8),
              child: Text("Your Date of Birth", style: kPresentTheme.titleTextStyle),
            ),
            CalendarDatePicker(

              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2222),
              onDateChanged: (valueChanged) {

                //var newFormat = DateFoermat("dd-mm-yyyy");

                profileCollector.dateOfBirth = valueChanged;//'${valueChanged.day}/${valueChanged.month}/${valueChanged.year}';


              },
            ),
          ],
        ),
      ),
    );

  }
}


class IncomePicker extends StatefulWidget {
 // const IncomePicker({Key? key}) : super(key: key);


  String incomePicker;

  IncomePicker({incomePicker});

  @override
  _IncomePickerState createState() => _IncomePickerState();
}

class _IncomePickerState extends State<IncomePicker> {

  int selectedValue = 0;


  List <double> incomeRangeList  = [

    1,
    5,
    10,
    20,
     0,

  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28,left:8, right : 8),
      child: InputCard(
        titleText: "Your income range",
        children: [
          RadioListTile(
              value: 1,
              groupValue: selectedValue,
              title: Text("Below 1 Lakh ", style: kDarkTextStyle,),

              onChanged: (value){
                setState(() {

                  selectedValue = value;
                  profileCollector.annualIncome = incomeRangeList[selectedValue];
                });


              }),
          RadioListTile(
              value: 2,
              groupValue: selectedValue,
              title: Text("Above 1 Lakh to 5 lakh", style: kDarkTextStyle,),

              onChanged: (value){

                setState(() {

                  selectedValue = value;
                  profileCollector.annualIncome = incomeRangeList[selectedValue];
                });


              }),
          RadioListTile(
              value: 3,
              groupValue: selectedValue,
              title: Text("Above 5 Lakh  to 10 Lakh", style: kDarkTextStyle,),

              onChanged: (value){

                setState(() {

                  selectedValue = value;
                  profileCollector.annualIncome = incomeRangeList[selectedValue];
                });

              }),
          RadioListTile(
              value: 4,
              groupValue: selectedValue,
              title: Text("Above 10 Lakh ", style: kDarkTextStyle,),

              onChanged: (value){

                setState(() {

                  selectedValue = value;
                  profileCollector.annualIncome = incomeRangeList[selectedValue];
                });

              }),
          RadioListTile(
              value: 5,
              groupValue: selectedValue,
              title: Text("Prefer not to disclose ", style: kDarkTextStyle,),

              onChanged: (value){

                setState(() {

                  selectedValue = value;
                  profileCollector.annualIncome = incomeRangeList[selectedValue] * 100000;
                });

              }),



        ],
      ),
    );
  }
}




/// Shows the collected data before saving


