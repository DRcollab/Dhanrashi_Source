import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/screens/tnc.dart';
import 'package:flutter/material.dart';

import '../components/custom_scaffold.dart';

class InfoPage extends StatelessWidget {

  InfoPage({required this.currentUser});

  var currentUser;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      currentUser: this.currentUser,
      leftButton: SizedBox(),
      rightButton: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon:Icon(Icons.close),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultValues.setLogo(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Text(' Financial Wisdom ver : 1.0.0', style: DefaultValues.kH2(context),)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Text(' Developed by', style: DefaultValues.kH4(context),)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child:
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [

                      Text('Dhanrashi Team', style: TextStyle(fontSize: 24),),

                    ],
                  ),
                  //Text(' by Arvind, Debashis and Shubhadeep', style: DefaultValues.kH2(context),),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 18.0),
          //   child: Center(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Text('Arvind',style: DefaultValues.kH2(context)),
          //         Text('Debashis',style: DefaultValues.kH2(context)),
          //         Text('Shubhadeep',style: DefaultValues.kH2(context)),
          //         //Text(' by Arvind, Debashis and Shubhadeep', style: DefaultValues.kH2(context),),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Know our',style: DefaultValues.kNormal3(context),),
                LinkText(linkText: ' Terms and Condition' , onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TnC(),
                      )
                  );
                },),
              ],
            )),
          ),


        ],
      )
    );
  }
}


/// in case the information about the developers need to be shown the following code to be used
///


// CircleAvatar(
//                         radius: 40,
//                        backgroundImage:AssetImage('${DefaultValues.imageDirectory}/profiles/aravind_avatar.jpeg'),
//
//                       ),
//                       Text('Aravind',style: DefaultValues.kH3(context)),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundImage:AssetImage('${DefaultValues.imageDirectory}/profiles/deba_avatar.jpeg'),
//                       ),
//                       Text('Debashis',style: DefaultValues.kH3(context)),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundImage:AssetImage('${DefaultValues.imageDirectory}/profiles/shubha_avatar.jpeg'),
//                       ),
//                       Text('Shubhadeep',style: DefaultValues.kH3(context)),


