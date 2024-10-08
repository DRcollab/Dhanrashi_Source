
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import 'constants.dart';


class ErrorPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(' Lost Connection ', style:DefaultValues.kH1(context),),
          ),
        ),
        Container(
          margin: DefaultValues.kDefaultPaddingAllSame(context),
          child:Image.asset('images/no_connection.png',),

        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('It seems we have lost connection to the server',style:DefaultValues.kH2(context),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please check your data settings or wifi connection.',style:DefaultValues.kNormal2(context)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('If you are travelling out side your native place.',style:DefaultValues.kNormal2(context)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Checkout Data Roaming settings inside your phone settings',style:DefaultValues.kNormal2(context)),
              ),

            ],
          )
        ),
        CommandButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            buttonColor: kPresentTheme.accentColor,
            borderRadius: BorderRadius.circular(10),
            textColor: Colors.white,
            buttonText: ' Go back to Login Screen',
        ),

      ],
    );
  }
}
