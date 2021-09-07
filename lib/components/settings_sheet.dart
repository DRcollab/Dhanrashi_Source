import 'package:dhanrashi_mvp/components/band_class.dart';
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

class SettingSheet extends StatelessWidget {
  const SettingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x00000000),
      child: Wrap(
        // shrinkWrap: true,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(

            decoration: BoxDecoration(
                color: kPresentTheme.themeColor,//Color(0x00000000),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset.zero,
                    blurRadius: 0.5,
                    spreadRadius: 1,

                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.wrench),
                    Center(child: Text('Settings', style:DefaultValues.kH1(context),)),
                    CommandButton(
                        onPressed: (){},
                        buttonColor: kPresentTheme.accentColor,
                        borderRadius: BorderRadius.circular(5),
                        textColor: kPresentTheme.alternateColor,
                        buttonText: 'Save',

                    )
                  ],
                ),
              ),
            ),
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

             Center(child: Image.asset('images/settings.png', height: 200, width: 200,)),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.themeisle),
                title: Text('Current Theme', style:DefaultValues.kH1(context),),
                subtitle: Text('Light Theme', style:DefaultValues.kH3(context),),

              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sortNumericDown),
                title: Text('Number System', style: DefaultValues.kH1(context),),
                subtitle: Text('Indian Style', style: DefaultValues.kH3(context),),

              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.moneyBill),
                title: Text('Currency', style: DefaultValues.kH1(context),),
                subtitle: Text('INR', style: DefaultValues.kH3(context),),

              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.themeisle),
                title: Text('Setting', style: DefaultValues.kH1(context),),
                subtitle: Text('Indian Style', style: DefaultValues.kH3(context),),

              ),


          ]
          ),






        ],
      ),
    );
  }
}
