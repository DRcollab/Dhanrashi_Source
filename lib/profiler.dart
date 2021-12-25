

import 'package:dhanrashi_mvp/components/file_handeler_class.dart';
import 'package:dhanrashi_mvp/components/photo_sheet_class.dart';
import 'package:dhanrashi_mvp/data/global.dart';
import 'package:dhanrashi_mvp/data/user_access.dart';
import 'package:dhanrashi_mvp/profile_view.dart';
import 'package:showcaseview/showcaseview.dart';
import 'components/date_picker.dart';
import 'models/profile_collector.dart';
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


  /// instance of Collector to be used in collecting user data.



/// Not for here



/// Start of Profiler Page
/// This Widget class will take the profile details of the User
class ProfilerPage extends StatefulWidget {

/// Used to store if user wants to give details or not.
  var readyToGiveDetails = false;
  bool isItForUpdate = false;

/// used as named attribute to get the user data from the login page.
  //UserData currentUser = UserData('','','','','');
  var currentUser;

/// Constructor for Profile Page
  ProfilerPage({required this.currentUser, this.isItForUpdate = false});


  @override
  _ProfilerPageState createState() => _ProfilerPageState();
}

/// State class of Profile page
///



class _ProfilerPageState extends State<ProfilerPage> {

  int index = 0; /// Used to iterate to different su screen

  bool viewNavigationButton = true; /// used to hold comdition to show save button or navigator button

  GlobalKey _profileImageSCKey = GlobalKey();
  GlobalKey _fNameSCKey = GlobalKey();
  GlobalKey _lNameSCKey = GlobalKey();
  GlobalKey _datePickerKey = GlobalKey();
  GlobalKey _incomeSCKey = GlobalKey();

  GlobalKey _dpMonthReduceSCKey = GlobalKey();
  GlobalKey _dpMonthIncrSCKey = GlobalKey();
  GlobalKey _dpMonthSCKey = GlobalKey();
  GlobalKey _dpYearrKey = GlobalKey();
  GlobalKey _dpGridSCKey = GlobalKey();

   var profileCollector = Collector();
   late final List<Widget> CardChoice;
  var _nameKey;  // Used for user email validation
  var _lnameKey; // Used fot password validation
  static bool  _dateKeyValidation  = false;
  static bool _incomeValidation = false;
  String errorText = ''; // Used to display message on date validation
  late FirebaseFirestore fireStore;
  String profileImageSource = '';
  List<List<GlobalKey>> _showCaseKeys = [[]];

///  Holds the different screen header display .
  final List<String> headers = [
    "Great, Let's start with your name",
    'Choose your date of birth',
    //'Your age factors how  you choose your investments.',
    '',
    ''
  ];

  /// Holds the necessary desscription .. THIS NEED TO BE REVIEWED
  final List<String> description = [

    'Your name would be used to customize this app for you',
    '',
    '',
  ];

  List <String> incomeRangeList  = [

    "Below 1 Lakh",
    "1 Lakh to 5 lakh",
    "5 Lakh to 10 Lakh",
    "Above 10 Lakh",
    "N/A",

  ];
  /// LIST ENDS HERE

  final _key1 = GlobalKey();

@override
  void initState() {

  GlobalKey _profileImageSCKey = GlobalKey();
  GlobalKey _fNameSCKey = GlobalKey();
  GlobalKey _lNameSCKey = GlobalKey();
  GlobalKey _datePickerKey = GlobalKey();
  GlobalKey _incomeSCKey = GlobalKey();

  GlobalKey _dpMonthReduceSCKey = GlobalKey();
  GlobalKey _dpMonthIncrSCKey = GlobalKey();
  GlobalKey _dpMonthSCKey = GlobalKey();
  GlobalKey _dpYearrKey = GlobalKey();
  GlobalKey _dpGridSCKey = GlobalKey();
  _showCaseKeys = [
    [_profileImageSCKey,_fNameSCKey,_lNameSCKey],
    [_datePickerKey,_dpMonthReduceSCKey,_dpMonthSCKey,_dpMonthIncrSCKey,_dpYearrKey,_dpGridSCKey],
    [_incomeSCKey],
  ];

  index = 0;
 _nameKey = GlobalKey<FormState>();
 _lnameKey = GlobalKey<FormState>();

 profileCollector.fName.text = widget.currentUser.firstName!='N/A' ? widget.currentUser.firstName : '';
 profileCollector.lName.text = widget.currentUser.lastName!='N/A' ? widget.currentUser.lastName : '';
 profileCollector.dateOfBirth = widget.currentUser.DOB;
 if(widget.currentUser.profileImage.contains('/')){
   profileCollector.profileImage = widget.currentUser.profileImage.substring(DefaultValues.directoryOfPhoto.length+1);
 }else{
   profileCollector.profileImage = widget.currentUser.profileImage;
 }

 if(widget.currentUser.incomeRange!='') {
   profileCollector.annualIncome =
   this.incomeRangeList[this.incomeRangeList.indexOf(
       widget.currentUser.incomeRange)];
 }



 if(widget.currentUser.DOB.year.toString()!='1900'){

   _dateKeyValidation =true;
 }else{
   _dateKeyValidation = false;
 }

 if(widget.currentUser.incomeRange!=''){
   _incomeValidation = true;
 }
 else{
   _incomeValidation = false;
 }

  super.initState();



     CardChoice = [

      NamePicker(
        //key: _key1,
        fName: profileCollector.fName,
        lName: profileCollector.lName,
        lnameKey: _lnameKey,
        nameKey: _nameKey,
        profilePhoto: widget.currentUser.profileImage,
        changedPhoto: (path){
          profileCollector.profileImage = path;
        },
        showCaseKeys: this._showCaseKeys[0],
      ), /// THIS IS THE SCREEN TO COLLECT NAME AND LASTNAME

      DOBPicker(
        onDateChanged: (valueChanged) {

          profileCollector.dateOfBirth = valueChanged;//'${valueChanged.day}/${valueChanged.month}/${valueChanged.year}';

          _dateKeyValidation = true;
        },
        datePicker: widget.currentUser.DOB.toString(),
        showCaseKey: this._showCaseKeys[1],
      ), /// THIS SHOWS CALENDER DISPLAY AND COLLECT DOB

      IncomePicker(
        incomePicker: this.incomeRangeList.indexOf(widget.currentUser.incomeRange),
          validate:(value){

            profileCollector.annualIncome = incomeRangeList[value!.round()];
           // profileCollector.annualIncome = incomeOptions[value!.round()];
            _incomeValidation = true;

          },
        showCaseKey: this._showCaseKeys[2],
      ), /// THIS SHOWS THE RADIO OPTIONS TO COLLECT INCOME RANGE
      ///
      // ConfirmationPage(),/// THIS SHOWS THE ENTERED INFO FOR CONFIRMATION
    ];


  }




  @override
  Widget build(BuildContext context) {

    print('call me index : $index');

    /// toggles the view of save button and navigation button
    ///
    Widget navButton = NavigationButtonSet(   ///
      spaceBetween: 2.w,
      leftButtonText: "Back",
      rightButtonText: "Next",

      textColor: kPresentTheme.accentColor,
      rightButtonPressed: () {
        // responds when right navigation button pressed



        switch (index){
          case 0:
            if(_nameKey.currentState!.validate()){
              if(_lnameKey.currentState!.validate()){
                index++;
              }

            }
            break;
          case 1:
           // showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)
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

            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmationPage(
                  currentUser: widget.currentUser,
                  collector: profileCollector,
                  isItForUpdate: widget.isItForUpdate,
                )));
          }

      },
      leftButtonPressed: () {
        // Responds when left navigation button pressed

        setState(() {
          if (index>0) {

            index--;
            viewNavigationButton = true;
            this.errorText='';
            if(widget.currentUser.DOB.year.toString()=='1900'){
              _dateKeyValidation = false;
            }
            else{
              _dateKeyValidation = true;
            }

            if(widget.currentUser.incomeRange == ''){
              _incomeValidation = false;
            }else{
              _incomeValidation = true;
            }

          }
          else{
            Navigator.pop(context);
            if(widget.isItForUpdate) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      ProfileView(currentUser: widget.currentUser,)));
            }else{

            }
          }
        },
        );
      },
    );  /// Navigation button



/// holds the different screens for collecting user data///
    ///




    //Widget comButt =  /// Command Button


    return ShowCaseWidget(

      builder: Builder(
        builder: (context) {
          return CustomScaffold(
            helper: (){
              ShowCaseWidget.of(context)!.startShowCase(_showCaseKeys[index]);
            },
            currentUser: widget.currentUser,
            allowToSeeBottom: true,
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
                        child: Text( headers[index],
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
  String profilePhoto = '${DefaultValues.directoryOfPhoto}/profile_image0.png';
  var nameKey = GlobalKey<FormState>();
  var lnameKey = GlobalKey<FormState>();
  Function(String path) changedPhoto;
  List<GlobalKey?>? showCaseKeys;
 // GlobalKey? key;
  NamePicker( {
    required this.fName,
    required this.lName,
    required this.nameKey,
    required this.lnameKey,
    required this.profilePhoto,
    required this.changedPhoto,
    this.showCaseKeys,
   // required this.key,
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
  late String profileImage;

  @override
  initState(){
    super.initState();
    if(widget.profilePhoto.contains('question')){
      profileImage = 'profile_image0.png';
      widget.changedPhoto(profileImage);
    }
    else {
      profileImage = widget.profilePhoto.substring(
        DefaultValues.directoryOfPhoto.length + 1,);
    }
    print(profileImage);
    jSon =  JsonHandler(fileName: 'settings.json');
    // profilePhotoSource = widget.profilePhoto;

  }


  @override
  Widget build(BuildContext context) {


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
                                              profileImage = 'profile_image$value.png';
                                              widget.changedPhoto(profileImage);
                                            });


                                    },)
                                  ),
                                ));
                          }
                          ,

                          child: Showcase(
                            key: widget.showCaseKeys![0],
                            description: 'Change your profile image here',
                            shapeBorder: CircleBorder(),
                            overlayPadding: EdgeInsets.all(4),
                            contentPadding: EdgeInsets.all(8),
                            child: CircleAvatar(

                                radius: 11.w,
                                backgroundImage:AssetImage('${DefaultValues.directoryOfPhoto}/${profileImage}'),
                            ),
                          ),
                        ),

                        Text('Click the image to Edit'),
                        SizedBox(height: 2.h,),
                        Padding(
                            padding:DefaultValues.kTextFieldPadding(context),
                                child: Form(
                                  key:widget.nameKey,
                                  child: Showcase(
                                    key:widget.showCaseKeys![1],
                                    description:'Enter your first name',
                                    shapeBorder: CircleBorder(),
                                    overlayPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal:10),
                                    contentPadding: EdgeInsets.all(10),
                                    child: CustomTextField(
                                      onSubmit: (){
                                        widget.nameKey.currentState!.validate();
                                      },
                                          validator: (value){
                                            if(value.toString().isEmpty){
                                               return 'First Name should not be empty';

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
                              ),
                        Padding(
                              padding: DefaultValues.kTextFieldPadding(context),
                                  child: Showcase(
                                    key:widget.showCaseKeys![2],
                                    description:'Enter your lastname here',
                                    shapeBorder: CircleBorder(),
                                    overlayPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal:10),
                                    contentPadding: EdgeInsets.all(8),
                                    child: Form(
                                      key: widget.lnameKey,
                                      child: CustomTextField(
                                        onSubmit: (){
                                          widget.lnameKey.currentState!.validate();
                                        },
                                        textInputAction: TextInputAction.done,
                                        validator: (value){
                                          if(value.toString().isEmpty){
                                            return 'last name should not be empty';

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

  List<GlobalKey?>? showCaseKey;

  DOBPicker({

    this.datePicker= '',
    this.dateValidated = false,
    required this.onDateChanged,
    this.showCaseKey,

  });

  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {

  String errorText = '';


  @override
  void initState() {

    super.initState();
  }

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

           Showcase(
             key:widget.showCaseKey![0],
             description: 'Pick your date of birth',
             child: Calendar
               (
               showCaseKeys: widget.showCaseKey!.sublist(1),
              //DateTimeFormField(
                initialDate: widget.datePicker.toString()=='1900-01-01 00:00:00.000'? DateTime( DateTime.now().year-18,DateTime.now().month, DateTime.now().day)
                 :DateTime.parse(widget.datePicker),
                textColor: Colors.black,
                selectTextColor: Colors.white,
                selectColor: kPresentTheme.accentColor,
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                backColor: kPresentTheme.influenceColors[0].withOpacity(0.4),
               // cellColor: kPresentTheme.influenceColors[0],
                onDateChanged: (valueChanged){
                  setState(() {
                    widget.onDateChanged(valueChanged);
                    if(!widget.dateValidated)
                      this.errorText = 'Please select a date before continue';
                  });

                }

              ),
           ),


          ],
        ),
      ),
    );

  }
}


class IncomePicker extends StatefulWidget {
 // const IncomePicker({Key? key}) : super(key: key);


  int incomePicker = 0;

  Function(int?)? validate;

 List<GlobalKey?>? showCaseKey;

  IncomePicker({
    this.incomePicker=0,
    required this.validate,
    this.showCaseKey,
  });

  @override
  _IncomePickerState createState() => _IncomePickerState();
}

class _IncomePickerState extends State<IncomePicker> {

  int selectedValue = 0;

  List<String> incomeOptions = [
    'Below 1 Lakh',
    '1 Lakh to 5 lakh',
    '5 Lakh to 10 Lakh',
    'Above 10 Lakh',
    'N/A',

  ];

  @override
  void initState() {


    if(widget.incomePicker!=0){

   //   this.selectedValue = this.incomeOptions.indexOf(widget.incomePicker);
      widget.validate!(selectedValue);

    }

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left:4.w, right: 4.w),
      child: Showcase(
        key:widget.showCaseKey![0],
        description: 'Pick your Income range',
        child: InputCard(
          titleText: "Your Annual Income",
          children: [
            RadioListTile(
                value: 0,
                groupValue: selectedValue,
                title: Text(this.incomeOptions[0], style:DefaultValues.kNormal2(context),),

                onChanged:  (value){
                  setState(() {
                    widget.validate!(int.parse(value.toString()));
                    selectedValue = int.parse(value.toString());

                  });


                }),
            RadioListTile(
                value: 1,
                groupValue: selectedValue,
                title: Text('Above ${this.incomeOptions[1]}', style:DefaultValues.kNormal2(context),),
                onChanged: (value){

                  setState(() {
                    widget.validate!(int.parse(value.toString()));
                    selectedValue = int.parse(value.toString());

                  });


                }),
            RadioListTile(
                value: 2,
                groupValue: selectedValue,
                title: Text('Above ${this.incomeOptions[2]}', style:DefaultValues.kNormal2(context),),

                onChanged: (value){

                  setState(() {
                    widget.validate!(int.parse(value.toString()));
                    selectedValue = int.parse(value.toString());

                  });

                }),
            RadioListTile(
                value: 3,
                groupValue: selectedValue,
                title: Text(this.incomeOptions[3], style:DefaultValues.kNormal2(context),),

                onChanged: (value){

                  setState(() {
                    widget.validate!(int.parse(value.toString()));
                    selectedValue = int.parse(value.toString());

                  });

                }),
            RadioListTile(
                value: 4,
                groupValue: selectedValue,
                title: Text('Prefer not to disclose', style:DefaultValues.kNormal2(context),),

                onChanged: (value){

                  setState(() {
                    widget.validate!(int.parse(value.toString()));
                    selectedValue = int.parse(value.toString());

                  });

                }),



          ],
        ),
      ),
    );
  }
}




/// Shows the collected data before saving


