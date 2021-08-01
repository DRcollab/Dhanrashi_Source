import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:dhanrashi_mvp/components/tile_class.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
//import 'components/tile_class.dart';





class InvestmentInputScreen extends StatelessWidget {
  //const InvestmentInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,top: 18.0),
                    child: Text("Investments",
                        style: kH1,

                    ),
                  ),

                // Image.asset('images/investing-pana.png', height: 200, width: 200,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Tile(
                        imageSource: 'images/info.png',
                        height: 150,
                        width: 150,
                        title: 'Mutual Fund',
                      ),



                  ],
                )
              ],
        ),
      ),
    );
  }
}
