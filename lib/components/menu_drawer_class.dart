import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DrawerHeader(

            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(radius: 20,backgroundColor: Colors.amber,),
                Align(
                    alignment: Alignment.topRight,

                    child: Text('Dhanrashi', style: kH1,)),

              ],
            ),
            decoration: BoxDecoration(
              color: kPresentTheme.alternateColor,
            ),


          ),
          Flexible(
            child: Container(
              
              child: ListView(
                children: [


                  ListTile(
                    leading: Icon(Icons.account_box_sharp, ),
                    title: Text('Update profile'),

                  ),
                  ListTile(
                    leading: Icon(Icons.add_chart),
                    title: Text('Go to Dashboard'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet_rounded),
                    title: Text('Add Investments'),
                  ),
                  ListTile(
                    leading: Icon(Icons.assistant_photo_rounded),
                    title: Text('Add Goals'),
                  )

                ],
              ),
            ),
          ),
          Container(
              child: ListTile(
                leading:Icon(Icons.logout),
                title: Text('Logout'),
              )
          )
        ],
      ),
    );
  }
}
