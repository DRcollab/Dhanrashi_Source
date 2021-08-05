import 'package:flutter/material.dart';
import 'package:dhanrashi_mvp/constants.dart';
import 'custom_text_field.dart';
import 'irregular_shapes.dart';



class GradientCard extends StatelessWidget {

   Widget child;

  GradientCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(


        boxShadow: [
          BoxShadow(
            color: kPresentTheme.shadowColor,
            offset: Offset(2.0,2.0),
            blurRadius: 5.0,
            spreadRadius: 1.5,

          )
        ],
        gradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: kPresentTheme.cardColors,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        //color: kPresentTheme.titleColor,

      ),

      child: CustomPaint(
        painter: CurvePainter(),
        child: this.child,
      ),
    );
  }
}

class InputCard extends StatelessWidget {

 // Widget child;
  Color color;
  String titleText = "Title";

  List<Widget> children;
  MainAxisAlignment mainAxisAlignment;

  InputCard({
   //required this.child,
    this.color = Colors.blueAccent,
     this.titleText = '',
    required this.children,
    this.mainAxisAlignment= MainAxisAlignment.spaceBetween,

  }

    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GradientCard(
          // Gradient card is custom card for this project..
          // The defintion is at the bottom of this file
        child: Column(
          mainAxisAlignment: this.mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: titleText == "" ? 0: 20 ),
              child: Center(
                child: Text(
                  this.titleText,
                  style: kPresentTheme.titleTextStyle,
                ),
              ),
            ), // Title Bar of the custom card
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: this.children,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  // const ReportCard({Key? key}) : super(key: key);

  //final Widget child;
  final Color color;
  final String titleText;

  final List<Widget> children;
  final BorderRadius borderRadius;

  final bool requiredTitleBar;
  final Color baseColor;

  ReportCard({
    //this.child,
    this.color = Colors.amber,
    this.titleText = "Title",
    required this.children,

    required this.borderRadius,
    this.requiredTitleBar = true,
    required this.baseColor,
  });

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  String titleText = "";
  bool requiredTitleBar = true;

  var titleColor;


  @override
  void initState() {
    //titleText= widget.titleText;
    requiredTitleBar = widget.requiredTitleBar;

    if (requiredTitleBar) {
      titleText = widget.titleText;
      titleColor = widget.color;
    } else {
      titleText = "";
      titleColor = Color(0x00000000);
    }

    titleText = requiredTitleBar ? widget.titleText : "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: widget.baseColor,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              // color: Colors.amber,

              decoration: BoxDecoration(
                  borderRadius: widget.borderRadius, color: titleColor),
              child: Padding(
                padding: requiredTitleBar
                    ? EdgeInsets.symmetric(vertical: 10.0)
                    : EdgeInsets.zero,
                child: Center(
                  child: Text(
                    titleText,
                    style: TextStyle(
                      color: kPresentTheme.darkTextColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ), // Title Bar of the custom card
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.children,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}



class OptionCard extends StatelessWidget {

  List< Widget> children;
  final void Function() optionOneReplied;
  final void Function() optionTworeplied;

  OptionCard({  required this.children, required this.optionOneReplied, required this.optionTworeplied});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Container(

        decoration: BoxDecoration(
          //  color: Colors.red,
          border: Border(
            top: BorderSide(width: 5.0,color: Colors.white),
            left: BorderSide(width: 5.0,color: Colors.white),
            bottom: BorderSide(width: 5.0,color: Colors.white),
            right: BorderSide(width: 5.0,color: Colors.white),

          ),
          boxShadow: [
            BoxShadow(
              color: kPresentTheme.shadowColor,
              offset: Offset(2.0,2.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,

            )
          ],
          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [Color(0xAAe8f54a),Color(0xFFe8f54a)]
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          //color: kPresentTheme.titleColor,

        ),

        child: CustomPaint(
          painter: CurvePainter(type: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: optionOneReplied,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(28.0),
                    child: this.children[0],

                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: optionTworeplied,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: this.children[1],
                  ),
                ),
              )

            ]


          ),
        ),
      ),
    );
  }
}


