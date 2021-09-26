

import 'package:dhanrashi_mvp/components/file_handeler_class.dart';
import 'package:dhanrashi_mvp/components/photo_sheet_class.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:sizer/sizer.dart';
import 'components/buttons.dart';
import 'components/custom_card.dart';
import 'components/custom_scaffold.dart';
import 'dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/constants.dart';
import 'components/custom_text_field.dart';
import 'components/buttons.dart';
import 'models/profile.dart';
import 'models/user_data_class.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'confirmation_page.dart';
import 'components/band_class.dart';  // confirmation page contains band class objects
import 'package:dhanrashi_mvp/data/database.dart';
import 'package:dhanrashi_mvp/data/user_handler.dart';
import 'package:dhanrashi_mvp/data/validators.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/// Used to collect data from different screen of the profiler page and compile the data
class Collector{


  DateTime _dateOfBirth = DateTime.now();
  String _annualIncome = '' ;
  var  _fName = TextEditingController() ;
  var _lName = TextEditingController();
  String profileImage = 'images/profiles/profile_image0.png';

/// Constructor of  the class

  Collector(){

      _dateOfBirth = DateTime.now();
     _annualIncome = '';
     _fName = TextEditingController();
     _lName = TextEditingController();
      profileImage = 'images/profiles/profile_image0.png';


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
  set annualIncome(String income){

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
 String get annualIncome{

    return _annualIncome;

  }

  String dateAsString(){

      return '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}';
  }

  }

  /// instance of Collector to be used in collecting user data.



/// Not for here



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
  late FirebaseFirestore fireStore;
  String profileImageSource = '';

///  Holds the different screen header display .
  final List<String> headers = [
    "Great, Let's start with your name",
    'Pick your date of birth',
    //'Your age factors how  you choose your investments.',
    'Your information will be safe with us',
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
      profilePhotoSource: profileCollector.profileImage,


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

        List <String> incomeRangeList  = [
          "Below 1 Lakh ",
          "1 Lakh to 5 lakh",
          "5 Lakh  to 10 Lakh",
          "Above 10 Lakh",
          "NA",
        ];

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
      spaceBetween: 2.w,
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
            Navigator.pop(context);
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

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,

                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical:2.h, horizontal: 4.w),
                  child: Text(

                    headers[index],
                    style: DefaultValues.kH2(context),
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
  String profilePhotoSource = 'images/profiles/profile_image0.png';

  var nameKey = GlobalKey<FormState>();
  var lnameKey = GlobalKey<FormState>();

  NamePicker( {
    required this.fName,
    required this.lName,
    required this.nameKey,
    required this.lnameKey,
    required this.profilePhotoSource,
  });


  setVariants(nameKey, lnameKey){
    this.nameKey = nameKey;
    this.lnameKey = lnameKey;

  }



  @override
  _NamePickerState createState() => _NamePickerState();
}

class _NamePickerState extends State<NamePicker> {


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
    print('profile pict is :: $widget.profilePhotoSource');


  }


  @override
  Widget build(BuildContext context) {


   //   print('profile image is @@@@@ $_profilePhotoSource');


    return  Padding(
        padding: EdgeInsets.only(top:4.h,left: 4.w,right: 4.w,bottom: 2.h),
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
                                        widget.profilePhotoSource = 'images/profiles/profile_image$value.png';
                                      });
                                   //  var settings = JsonHandler(fileName: 'settings.json');
                                   //  settings.createFile({'profile':this._profilePhotoSource});

                                      print(widget.profilePhotoSource);

                              },)
                            ),
                          ));
                    }
                    ,
                    child: CircleAvatar(
                        radius: 11.w,
                        backgroundImage:AssetImage(widget.profilePhotoSource),
                    ),
                  ),


                  SizedBox(height: 4.h,),
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
                        padding: DefaultValues.kTextFieldPadding(context),
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
      padding: EdgeInsets.only(top: 2.h, left:4.w, right: 4.w),
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
      padding: EdgeInsets.only(top: 2.h, left:4.w, right: 4.w),
      child: InputCard(
        titleText: "Your income range",
        children: [
          RadioListTile(
              value: 0,
              groupValue: selectedValue,
              title: Text("Below 1 Lakh ", style:DefaultValues.kNormal2(context),),

              onChanged:  (value){
                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });


              }),
          RadioListTile(
              value: 1,
              groupValue: selectedValue,
              title: Text("Above 1 Lakh to 5 lakh", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });


              }),
          RadioListTile(
              value: 2,
              groupValue: selectedValue,
              title: Text("Above 5 Lakh  to 10 Lakh", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });

              }),
          RadioListTile(
              value: 3,
              groupValue: selectedValue,
              title: Text("Above 10 Lakh ", style:DefaultValues.kNormal2(context),),

              onChanged: (value){

                setState(() {
                  widget.validate!(int.parse(value.toString()));
                  selectedValue = int.parse(value.toString());

                });

              }),
          RadioListTile(
              value: 4,
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


