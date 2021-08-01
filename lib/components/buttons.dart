import 'package:flutter/material.dart';

import 'package:dhanrashi_mvp/constants.dart';

enum LinkTextType {
  DARK,
  LIGHT,
}

class OptionGroup{

 static List<Color> group = [kPresentTheme.accentButtonColor, kPresentTheme.accentButtonColor];

  static void add(Color x){

    group.add(x);
  }

}




class CommandButton extends StatelessWidget {
  String buttonText = "Button";
  Function onPressed;
  IconData icon;
  Color buttonColor = kDarkColor;
  double textSize = 20.0;
  double inducedHeight = 40;
  Color textColor;
  BorderRadius borderRadius = BorderRadius.circular(20.0);

  CommandButton({
    this.buttonText,
    @required this.onPressed,
    this.icon,
    this.buttonColor,
    this.textSize,
    @required this.borderRadius,
    this.inducedHeight = 40.0,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: inducedHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: this.buttonColor,
            textStyle: TextStyle(
              fontSize: this.textSize,
              fontWeight: FontWeight.bold,
              // color: Colors.red,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: this.borderRadius,
            )),
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
      ),
    );
  }
}


class OptionButton extends StatefulWidget {
  final String buttonText;

  final Color textColor;

  final Function onPressed;

   Color backColor;
  int index = 0;


   OptionButton({this.buttonText = "Button",this.textColor = kLightTextColor,@required this.onPressed, this.index, @required this.backColor}){
    // OptionGroup.add(this.backColor);
   }


  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  //ExpandedButton({});
  String buttonText;
  Color textColor;
  Function onPressed;
  Color backColor;

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
              if(OptionGroup.group[widget.index]==kPresentTheme.accentButtonColor){

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
  Function onPressed;
  LinkTextType type = LinkTextType.DARK;
  double displaySize = 25.0;

  LinkText(
      {this.linkText, @required this.onPressed, this.type, this.displaySize});

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
  Function leftButtonPressed;
  Function rightButtonPressed;
  String leftButtonText = "Back";
  String rightButtonText = "Next";
  Color leftButtonColor;
  Color rightButtonColor;
  double spaceBetween = 0.0;
  Color textColor;

  NavigationButtonSet({
    @required this.leftButtonPressed,
    @required this.rightButtonPressed,

    this.leftButtonText = "Back",
    this.rightButtonText = "Next",
    this.spaceBetween = 0.0,
    this.textColor,
  });



  @override
  Widget build(BuildContext context) {
    this.leftButtonColor = this.rightButtonColor = kPresentTheme.navigationColor; // Defined color from present theme.

    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(right: this.spaceBetween / 2),
            child: CommandButton(
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



