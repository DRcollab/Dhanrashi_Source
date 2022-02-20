import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/profiler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'components/buttons.dart';
import 'models/profile.dart';

class ProfileView extends StatelessWidget {
  //const ProfileView({Key? key}) : super(key: key);

  late final currentUser;

  ProfileView(
      {required this.currentUser}
      );

  @override
  Widget build(BuildContext context) {
   DateTime now = DateTime.now();
   Duration duration = Duration();



  double age = (currentUser.DOB.difference(now).inDays/365);


  String ageAsString = age.ceil().toString();

    return CustomScaffold(
        currentUser: this.currentUser,
        rightButton: SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          // Image.asset('images/profile_image.png', height: 150,width: 250,alignment: Alignment.topCenter,),
            SizedBox(height: 15.h ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               // requiredTitleBar: false,
               // borderRadius: BorderRadius.circular(20),
               // baseColor: kPresentTheme.themeColor,
                children: [
                  CircleAvatar(
                    radius: 40 * DefaultValues.adaptForSmallDevice(context),
                    backgroundColor: kPresentTheme.accentColor,
                    backgroundImage: AssetImage(this.currentUser.profileImage),
                  ),
                  Text('${currentUser.firstName} ${currentUser.lastName}',style: DefaultValues.kH1(context),),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                    child: Text(currentUser.email, style: DefaultValues.kNormal2(context),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                    child: Text('Income Range: ${currentUser.incomeRange}', style: DefaultValues.kNormal2(context),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                    child: Text( 'Date of Birth :${DateFormat('dd-MM-yyyy').format(currentUser.DOB.toLocal())}', style: DefaultValues.kNormal2(context),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                    child: Text( 'Age:${ageAsString} years', style: DefaultValues.kNormal2(context),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                    child: CommandButton(
                      borderRadius: BorderRadius.circular(5),
                      buttonColor: kPresentTheme.accentColor,
                      buttonText: 'Update',
                      textColor: kPresentTheme.lightWeightColor,
                      onPressed: (){

                       Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ProfilerPage(currentUser: this.currentUser,isItForUpdate: true,)));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left:30.w,
                      right: 30.w, ),
                    child: CommandButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      buttonColor: kPresentTheme.alternateColor,
                      borderRadius: BorderRadius.circular(5),
                      textColor: kPresentTheme.accentColor,
                      buttonText: 'Cancel',


                    ),
                  )
                ],
              ),
          ),

          ],
        )

    );
  }
}
