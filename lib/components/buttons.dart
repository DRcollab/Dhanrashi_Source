

import 'package:flutter/material.dart';

import 'package:dhanrashi_mvp/constants.dart';

enum LinkTextType {
  DARK,
  LIGHT,
}

class OptionGroup{

 static List<Color> group = [kPresentTheme.accentColor, kPresentTheme.accentColor];

  static void add(Color x){

    group.add(x);
  }

}




class CommandButton extends StatelessWidget {
  String buttonText = "Button";
   void Function() onPressed;
  //IconData icon;
  late Color buttonColor = kPresentTheme.accentColor;
  double textSize = 20.0;
  double inducedHeight = 20;
  Color textColor;
  BorderRadius borderRadius = BorderRadius.circular(20.0);

  CommandButton({
    this.buttonText = '',
    required this.onPressed,
    //required this.icon,
    required this.buttonColor,
    this.textSize = 18,
    required this.borderRadius,
    this.inducedHeight = 40.0,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
              primary: this.buttonColor,
                textStyle: TextStyle(
                  fontSize: this.textSize,
                  fontWeight: FontWeight.bold,
            // color: Colors.red,
                    ),
              shape: RoundedRectangleBorder(
                 borderRadius: this.borderRadius,
                  ),
              ),// Elevated Button Stylefrom

        onPressed: this.onPressed,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              buttonText,
              style: TextStyle(
              color: this.textColor,
          ),
        ),
      ),
    );
  }
}


class OptionButton extends StatefulWidget {
  final String buttonText;

  final Color textColor;

 final void Function() onPressed;

   late Color backColor;
  int index = 0;


   OptionButton({this.buttonText = "Button",this.textColor = Colors.white,required this.onPressed, this.index=0, required this.backColor}){
    // OptionGroup.add(this.backColor);
   }


  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  //ExpandedButton({});
  String buttonText = '';
  var textColor ;
  late Function onPressed;
  late Color backColor;

  initState() {
    buttonText = widget.buttonText;
    textColor = widget.textColor;
    onPressed = widget.onPressed;
    backColor = widget.backColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kTextFieldPadding,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for(Color color in OptionGroup.group){
              if(OptionGroup.group[widget.index]==kPresentTheme.accentColor){

                OptionGroup.group[widget.index] = Colors.red;
                print(OptionGroup.group);
              }

            }

            onPressed();
          });
        },
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: this.backColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: this.backColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: TextStyle(
              color: this.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  String linkText = "Link Text";
  final void Function() onPressed;
  LinkTextType type = LinkTextType.DARK;
  double displaySize = 15.0;

  LinkText(
      {this.linkText = 'Link Text', required this.onPressed, this.type = LinkTextType.DARK, this.displaySize= 18.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        linkText,
        style: TextStyle(
          color: type == LinkTextType.DARK ? kPresentTheme.linkTextColor : Colors.white,
          fontSize: this.displaySize,
        ),
      ),
      onTap: onPressed,
    );
  }
}

class NavigationButtonSet extends StatelessWidget {
  final void Function() leftButtonPressed;
  final void Function() rightButtonPressed;
  String leftButtonText = "Back";
  String rightButtonText = "Next";
  late Color leftButtonColor;
  late Color rightButtonColor;
  double spaceBetween = 0.0;
  late Color textColor;

  NavigationButtonSet({
    required this.leftButtonPressed,
    required this.rightButtonPressed,

    this.leftButtonText = "Back",
    this.rightButtonText = "Next",
    this.spaceBetween = 0.0,
    this.textColor = Colors.black,
  });



  @override
  Widget build(BuildContext context) {
    this.leftButtonColor = this.rightButtonColor = kPresentTheme.alternateColor; // Defined color from present theme.

    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(right: this.spaceBetween / 2),
            child: CommandButton(
              //icon: Icons.chevron_left,
              buttonColor: this.leftButtonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),

              ),
              buttonText: this.leftButtonText,
              textColor: textColor,
              onPressed: this.leftButtonPressed,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: this.spaceBetween / 2),
            child: CommandButton(
              //icon: Icons.chevron_right,
              buttonColor: this.rightButtonColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              buttonText: this.rightButtonText,
              textColor: this.textColor,
              onPressed: this.rightButtonPressed,
            ),
          ),
        ],
      ),
    );
  }
}



