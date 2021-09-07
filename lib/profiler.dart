

import 'package:dhanrashi_mvp/components/file_handeler_class.dart';
import 'package:dhanrashi_mvp/components/photo_sheet_class.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';

import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'dashboard_old.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/constants.dart';
import 'components/custom_text_field.dart';
import 'components/buttons.dart';
import 'models/user_data_class.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'confirmation_page.dart';
import 'components/band_class.dart';  // confirmation page contains band class objects
import 'package:dhanrashi_mvp/data/database.dart';
import 'package:dhanrashi_mvp/data/user_handler.dart';
import 'package:dhanrashi_mvp/data/validators.dart';



/// Used to collect data from different screen of the profiler page and compile the data
class Collector{


  DateTime _dateOfBirth = DateTime.now();
  double _annualIncome = 0.0 ;
  var  _fName = TextEditingController() ;
  var _lName = TextEditingController();

/// Constructor of  the class

  Collector(){

      _dateOfBirth = DateTime.now();
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
  //UserData currentUser = UserData('','','','','');
  var currentUser;

/// Constructor for Profile Page
  ProfilerPage({required this.currentUser});


  @override
  _ProfilerPageState createState() => _ProfilerPageState();
}

/// State class of Profile page
///



class _ProfilerPageState extends State<ProfilerPage> {

  int index = 0; /// Used to iterate to different su screen


  var _userHandler = UserHandeler(userTable, userProfileTable); /// used  to  handle user activity like saving and retrieving data


  bool viewNavigationButton = true; /// used to hold comdition to show save button or navigator button

  static var profileCollector = Collector();

  static var _nameKey = GlobalKey<FormState>(); // Used for user email validation
  static var _lnameKey = GlobalKey<FormState>(); // Used fot password validation
  static bool  _dateKeyValidation  = false;
  static bool _incomeValidation = false;
  String errorText = ''; // Used to display message on date validation

  String profileImageSource = '';

///  Holds the different screen header display .
  final List<String> headers = [
    "Great, Let's start with your name",
    'Pick your date of birth',
    //'Your age factors how  you choose your investments.',
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



    NamePicker(
      fName: profileCollector._fName,
      lName: profileCollector.lName,
      lnameKey: _lnameKey,
      nameKey: _nameKey,


        ), /// THIS IS THE SCREEN TO COLLECT NAME AND LASTNAME

    DOBPicker(
      onDateChanged: (valueChanged) {

        //var newFormat = DateFoermat("dd-mm-yyyy");

        profileCollector.dateOfBirth = valueChanged;//'${valueChanged.day}/${valueChanged.month}/${valueChanged.year}';

        _dateKeyValidation = true;
      },
    ), /// THIS SHOWS CALENDER DISPLAY AND COLLECT DOB

    IncomePicker(
      validate:(value){

        List <double> incomeRangeList  = [1,5,10,20,0, ];

        profileCollector.annualIncome = incomeRangeList[value!.round()];
        _incomeValidation = true;
      }
    ), /// THIS SHOWS THE RADIO OPTIONS TO COLLECT INCOME RANGE
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

      textColor: kPresentTheme.accentColor,
      rightButtonPressed: () {
        // responds when right navigation button pressed

        print(index);

        switch (index){
          case 0:
            if(_nameKey.currentState!.validate()){
              if(_lnameKey.currentState!.validate()){
                index++;
              }

            }
            break;
          case 1:
            if(_dateKeyValidation){
              index++;
              errorText = '';
            }
            else{
              this.errorText = 'Select a date before continue';
            }

            break;
          case 2:
            if(_incomeValidation){
              index++;
              errorText = '';
            }
            else{
              this.errorText = 'Please select an option before continue';
            }

            break;

        }
         // index++;

          if (index < 3 ) {
            setState(() {
              viewNavigationButton = true;


            });

          }
          else{

           // viewNavigationButton = false;
            print('name ${profileCollector.fName.text}');

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmationPage(
                  currentUser: widget.currentUser,
                  collector: profileCollector,)));
          }

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
      currentUser: widget.currentUser,
      child: Container(
       // color: Colors.red,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Image.asset('images/profile_image.png',height: 200,width: 200,),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                //padding: const EdgeInsets.only(left:18, top:28),
                child: Text(

                  headers[index],
                  style: TextStyle(
                    color: kPresentTheme.accentColor,
                    fontSize: 24.0 * scaleSmallDevice(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            CardChoice[index],
            Center(child: Text(this.errorText, style:         // Display error message on validation fail
                                  TextStyle(
                                    color:Colors.red,

                                  ),),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child:  navButton,
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

  var fName = TextEditingController();
  var lName = TextEditingController();


  var nameKey = GlobalKey<FormState>();
  var lnameKey = GlobalKey<FormState>();

  NamePicker( {required this.fName, required this.lName, required this.nameKey, required this.lnameKey, });


  setVariants(nameKey, lnameKey){
    this.nameKey = nameKey;
    this.lnameKey = lnameKey;

  }



  @override
  _NamePickerState createState() => _NamePickerState();
}

class _NamePickerState extends State<NamePicker> {

  String _profilePhotoSource = 'images/profiles/profile_image0.png';
  var jSon;


  @override
  initState(){
    super.initState();
    jSon =  JsonHandler(fileName: 'settings.json');
    //jSon.readFile();
    // if(jSon.readSuccessful){
    //  _profilePhotoSource = jSon.fileContent['profile'];
    // //  print('profile pict is :: $_profilePhotoSource');
    // }
    print('profile pict is :: $_profilePhotoSource');


  }


  @override
  Widget build(BuildContext context) {


   //   print('profile image is @@@@@ $_profilePhotoSource');


    return  Padding(
        padding: EdgeInsets.only(top:28,left: 18,right: 18,bottom: 8),
        child: InputCard(
              titleText: "",
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: PhotoSheet(getChoice: (value){
                                      setState(() {
                                        this._profilePhotoSource = 'images/profiles/profile_image$value.png';
                                      });
                                   //  var settings = JsonHandler(fileName: 'settings.json');
                                   //  settings.createFile({'profile':this._profilePhotoSource});

                                      print(this._profilePhotoSource);
                              },)
                            ),
                          ));
                    }
                    ,
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage:AssetImage(this._profilePhotoSource),
                    ),
                  ),


                  SizedBox(height: 30,),
                  Padding(
                      padding:DefaultValues.kTextFieldPadding(context),
                          child: Form(
                            key:widget.nameKey,
                            child: CustomTextField(
                                  validator: (value){
                                    if(value.toString().isEmpty){
                                       return 'Name must not be empty';

                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  icon: Icons.badge,
                                  controller:  widget.fName,
                                  hintText: 'First Name',
                                  ),
                          ),
                        ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(
                            18.0 *DefaultValues.adaptForSmallDevice(context),
                            8.0 *DefaultValues.adaptForSmallDevice(context) ,
                            18.0 *DefaultValues.adaptForSmallDevice(context) ,
                            28.0 *DefaultValues.adaptForSmallDevice(context),
                        ),
                            child: Form(
                              key: widget.lnameKey,
                              child: CustomTextField(
                                textInputAction: TextInputAction.done,
                                validator: (value){
                                  if(value.toString().isEmpty){
                                    return 'lastname cannot be empty';

                                  }
                                  else {
                                    return null;
                                  }
                                },
                                  icon: Icons.badge,
                                  controller: widget.lName,
                                  hintText: 'Last Name',
                          ),
                            ),
                  ),

        ],
      ),
    );
  }
}


class DOBPicker extends StatefulWidget {
 // const DOBPicker({Key? key}) : super(key: key);

  String datePicker = '';

  bool dateValidated = false;
  void Function(DateTime) onDateChanged;
  DOBPicker({this.datePicker= '', this.dateValidated = false, required this.onDateChanged});

  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {

  String errorText = '';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, left:18, right: 18),
      child: GradientCard(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left:8,top:16,bottom: 0,right:8),
            //   child: Text("Your Date of Birth", style: kTitleTextStyle),
            // ),
           CalendarDatePicker(
            //DateTimeFormField(
              initialDate:  DateTime( DateTime.now().year-18,DateTime.now().month, DateTime.now().day),
              firstDate: DateTime(1900),
              lastDate: DateTime(2222),

              onDateChanged: (valueChanged){
                setState(() {
                  widget.onDateChanged(valueChanged);
                  this.errorText = 'Please select a date before continue';
                });

              }

            ),


          ],
        ),
      ),
    );

  }
}


class IncomePicker extends StatefulWidget {
 // const IncomePicker({Key? key}) : super(key: key);


  String incomePicker = '';

  Function(int?)? validate;

  IncomePicker({incomePicker='', required this.validate});

  @override
  _IncomePickerState createState() => _IncomePickerState();
}

class _IncomePickerState extends State<IncomePicker> {

  int selectedValue = 0;





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28,left:18, right : 18),
      child: InputCard(
        titleText: "Your income range",
        children: [
          RadioListTile(
              value: 1,
              groupValue: selectedValue,
              title: Text("Below 1 Lakh ", style:DefaultValues.kNormal2(context),),

              onChanged:  (value){
                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });


              }),
          RadioListTile(
              value: 2,
              groupValue: selectedValue,
              title: Text("Above 1 Lakh to 5 lakh", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });


              }),
          RadioListTile(
              value: 3,
              groupValue: selectedValue,
              title: Text("Above 5 Lakh  to 10 Lakh", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });

              }),
          RadioListTile(
              value: 4,
              groupValue: selectedValue,
              title: Text("Above 10 Lakh ", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });

              }),
          RadioListTile(
              value: 5,
              groupValue: selectedValue,
              title: Text("Prefer not to disclose ", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });

              }),



        ],
      ),
    );
  }
}




/// Shows the collected data before saving


