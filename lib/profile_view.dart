import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Image.asset('images/profile_image.png', height: 150,width: 250,alignment: Alignment.topCenter,),
            SizedBox(height: 130 * DefaultValues.adaptForSmallDevice(context),),
            ReportCard(
              requiredTitleBar: false,
              borderRadius: BorderRadius.circular(20),
              baseColor: kPresentTheme.themeColor,
              children: [
                CircleAvatar(
                  radius: 40 * DefaultValues.adaptForSmallDevice(context),
                  backgroundColor: kPresentTheme.accentColor,
                  backgroundImage: AssetImage(this.currentUser.profileImage),
                ),
                Text('${currentUser.firstName} ${currentUser.lastName}',style: DefaultValues.kH1(context),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(currentUser.email, style: DefaultValues.kNormal2(context),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Income Range: ${currentUser.incomeRange}', style: DefaultValues.kNormal2(context),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text( 'Date of Birth :${DateFormat('dd-MM-yyyy').format(currentUser.DOB.toLocal())}', style: DefaultValues.kNormal2(context),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text( 'Age:${ageAsString} years', style: DefaultValues.kNormal2(context),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommandButton(
                    borderRadius: BorderRadius.circular(5),
                    buttonColor: kPresentTheme.accentColor,
                    buttonText: 'Update',
                    textColor: kPresentTheme.lightWeightColor,
                    onPressed: (){},
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left:60.0 * DefaultValues.adaptForSmallDevice(context),
                  right: 60.0 *  DefaultValues.adaptForSmallDevice(context) ),
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
        )

    );
  }
}
