import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                //Image.asset('images/goldsrain.png'),
                CircleAvatar(radius: 50,backgroundColor: kPresentTheme.accentColor,),
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
                    //contentPadding: EdgeInsets.all(10),
                    leading: FaIcon(FontAwesomeIcons.userFriends,size: 30,color:kPresentTheme.accentColor, ),
                    title: Text('Update profile' ,style: kNormal2, ),

                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.chartPie,size: 30,color:kPresentTheme.accentColor),
                    title: Text('Go to Dashboard', style: kNormal2),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.plus,size: 30,color:kPresentTheme.accentColor),
                    title: Text('Add Investments', style: kNormal2),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.bullseye, size: 30,color:kPresentTheme.accentColor),
                    title: Text('Add Goals', style: kNormal2),
                  ),

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wrench, size: 30,color:kPresentTheme.accentColor),
                    title: Text('Settings', style: kNormal2),
                  ),

                  Container(height: 2,width: double.infinity,color: Colors.black12,),
                  SizedBox(height: 10,width: double.infinity,),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.calculator, size: 30,color:kPresentTheme.accentColor),
                    title: Text('SIP Calculator', style: kNormal2),
                  ),
                ],
              ),
            ),
          ),
          Container(
              child: ListTile(
                leading:Icon(Icons.logout,size: 35,color:kPresentTheme.accentColor),
                title: Text('Logout',style: kNormal2),
              )
          )
        ],
      ),
    );
  }
}
