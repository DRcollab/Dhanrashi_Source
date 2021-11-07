import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:flutter/material.dart';

import 'components/custom_scaffold.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
          CircleAvatar(
            backgroundColor: kPresentTheme.accentColor,
            radius: 40,

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:18.0),
            child: Center(child: Text(' Dhanrashi : ver - 1.0.0', style: DefaultValues.kH2(context),)),
          ),



        ],
      )
    );
  }
}
