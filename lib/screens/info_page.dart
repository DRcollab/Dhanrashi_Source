import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:dhanrashi_mvp/components/constants.dart';
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
            child: Center(child: Text(' Fincial Wisdom : ver - 1.0.0', style: DefaultValues.kH2(context),)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child:
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  //Text(' by Arvind, Debashis and Shubhadeep', style: DefaultValues.kH2(context),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: LinkText(linkText: 'Click Here to see our T & C document' , onPressed: () {  },)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Text(' We express our  thanks for using their creatives :', style: DefaultValues.kH2(context),)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Text(' Fincial Wisdom : ver - 1.0.0', style: DefaultValues.kH2(context),)),
          ),
        ],
      )
    );
  }
}
