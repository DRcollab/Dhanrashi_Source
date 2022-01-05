


import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class RecomCard extends StatefulWidget {


  late List dataSet;
  late List goals;
  late bool showHeader;
  late bool scrolledUp;



  @override
  State<RecomCard> createState() => _RecomCardState();

  RecomCard({required this.dataSet, required this.goals, this.showHeader=true, this.scrolledUp=false});
}

class _RecomCardState extends State<RecomCard> {
  //var dataSet;

 // var goals ;

  late ScrollController _scrollController;
  bool _showSummary = true;
  bool _scrollingUp = false;

   String recomMessage = '';
   String negativeMessage = 'You are behind your goals for';
   String positiveMessage = 'You are ahead of your goals for';

   int laggingGoals = 0;
   int leadingGoals = 0;

   late Widget displayWidget;




  _fetchRecommendations(){

      laggingGoals = 0;
      leadingGoals = 0;
    if(widget.dataSet.isNotEmpty){

      for (int i =1 ; i<widget.dataSet[3].length ; i++){
        if(double.parse(widget.dataSet[3][i])>0){
          positiveMessage   = positiveMessage + ' '+ widget.dataSet[0][i] + ',';
         leadingGoals ++;
        }else{
          negativeMessage   = negativeMessage + ' ' + widget.dataSet[0][i] + ',';
          laggingGoals ++;
        }
      }

      print(widget.dataSet);

      if(laggingGoals > 0 && laggingGoals> leadingGoals){
        recomMessage = '$laggingGoals of your goals are lagging...';
        displayWidget = Text(recomMessage, style: DefaultValues.kH2(context).copyWith(color: Colors.red),);
      }else{
        recomMessage = '$leadingGoals of your goals are doing well';
        displayWidget = Text(recomMessage, style: DefaultValues.kH2(context).copyWith(color: Colors.green),);
      }

      // widget.dataSet[3].forEach((element) {
      //  // print(element[4]);
      //    if( double.parse(element) > 0){
      //
      //   }else{
      //     negativeMessage =  negativeMessage + element[1];
      //   }
      // });
    }

   // recomMessage = Utility.formatMessage(negativeMessage) + ' years';

  //
  //   if (widget.goals.isNotEmpty) {
  //     widget.goals.forEach((element) {
  //       eachGoalYear = element.duration;
  //       eachGoalName = element.name;
  //       String eachInvTotal = widget.dataSet[0][eachGoalYear];
  //       String eachGoalTotal = widget.dataSet[1][eachGoalYear];
  //
  //
  //       if (double.parse(eachInvTotal) > double.parse(eachGoalTotal)) {
  //         recomMessage = 'You are ahead of your goals at $eachGoalYear years';
  //
  //       } else {
  //
  //          recomMessage =   'You are behind your goals at $eachGoalYear years and need to invest more';
  //       }
  //     });
  //   }
   }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {

      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){

        print('up');
        setState(() {
          _scrollingUp = false;
          _showSummary = false;
        });
      } else if(_scrollController.position == _scrollController.position.minScrollExtent){

        print('down');
        setState(() {
          _scrollingUp = true;
          _showSummary = true;
        });
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    print(widget.dataSet.length);
    _fetchRecommendations();


    return Container(
      color: Color(0x00000000),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top:18.0),
            child: ReportCard(

                borderRadius: BorderRadius.circular(20),
                baseColor: kPresentTheme.themeColor,
                titleText: '',
                requiredTitleBar: false,
                children: [
                widget.showHeader ? displayWidget : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 1,color: kPresentTheme.alternateColor),
                  ),
                  Container(
                    height: DefaultValues.screenHeight(context)/2,
                    child: ListView.builder(

                        itemCount: widget.dataSet[0].length-1,
                       // controller: _scrollController,
                        itemBuilder: (context, index){

                      return Shingle(
                          leadingImage: (double.parse( widget.dataSet[3][index+1])>0)?'images/accept.png':'images/remove.png',
                          type: 'goal',
                          title: 'Goals for ${widget.dataSet[0][index+1]} is ${double.parse( widget.dataSet[3][index+1])>0 ? 'leading':'lagging'}',
                          subtitle: 'by ${DefaultValues.financialFormat(DefaultValues.textFormatWithDecimal,double.parse( widget.dataSet[3][index+1]))}',
                          onPressed: (){}
                          );
                        }
                      //DefaultValues.financialFormat(DefaultValues.textFormatWithDecimal, widget.dataSet[3][index+1])
                    ),
                  ),
                  // Placard(
                  //     color:kPresentTheme.alternateColor,
                  //     child: Text(Utility.formatMessage(positiveMessage),
                  //       style: DefaultValues.kNormal3(context),),),
                  // Placard(
                  //     color: kPresentTheme.errorAccentColor,
                  //     child: Text(   Utility.formatMessage(negativeMessage),
                  //       style: DefaultValues.kNormal3(context),),),

                ],


            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left : 0.0, bottom: 0.0,top:10.0 ),
            child: Center(
                child: ExpandButton(
                      display: !widget.scrolledUp ? Icon(Icons.keyboard_arrow_up):Icon(Icons.keyboard_arrow_down),
                      color: kPresentTheme.themeColor,
                     onTap: (){

                        // showBottomSheet(context: context,
                        //     elevation: 2.0,
                        //     builder: (context) => SingleChildScrollView(child: Container(child: RecommSheet())));
                     }
                    )),
          ),

        ],
      ),
    );
  }
}


class RecommSheet extends StatelessWidget {
  const RecommSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color:kPresentTheme.themeColor,
      child: Container(

          child: Column(
            children:[
              Container(
                height: 5,
                color:kPresentTheme.alternateColor,
              ),
              Container(


                child:Row(
                  children: [
                    Text(' Present position of your goals'),
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close)),
                  ],
                )
              ),
              ListTile(
                  title: Text(' Goals are going well'),

              ),
              ListTile(
                title: Text(' Goals are going well'),

              ),
              ListTile(
                title: Text(' Goals are going well'),

              ),
              ListTile(
                title: Text(' Goals are going well'),

              ),
            ]

          ),
      ),
    );
  }
}
