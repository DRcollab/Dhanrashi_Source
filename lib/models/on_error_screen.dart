
import 'package:dhanrashi_mvp/components/buttons.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../login_page.dart';

class ErrorPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' Lost Connection ', style: kH1,),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
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
                  child: Text('It seems we have lost connection to the server',style: kH2,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Please check your data settings or wifi connection.',style: kNormal2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('If you are travelling out side your native place.',style: kNormal2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Checkout Data Roaming settings inside your phone settings',style: kNormal2),
                ),

              ],
            )
          ),
          CommandButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              buttonColor: kPresentTheme.accentColor,
              borderRadius: BorderRadius.circular(10),
              textColor: Colors.white,
              buttonText: ' Go back to Login Screen',
          ),

        ],
      ),
    );
  }
}
