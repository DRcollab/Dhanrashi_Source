


import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_card.dart';
import 'package:dhanrashi_mvp/components/round_button.dart';
import 'package:dhanrashi_mvp/components/shingle.dart';
import 'package:dhanrashi_mvp/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
class RecomCard extends StatefulWidget {


  late List dataSet;
  late List goals;
  late bool showHeader;
  late bool scrolledUp;
  late Function()? scrollControl;



  @override
  State<RecomCard> createState() => _RecomCardState();

  RecomCard({required this.dataSet, required this.goals, this.showHeader=true, this.scrolledUp=false, this.scrollControl});
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
   String positiveIcon = DefaultValues.imageDirectory + '/up.png';
   String negativeIcon = DefaultValues.imageDirectory + '/down.png';
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

    //style: DefaultValues.kNormal3(context).copyWith(color: kPresentTheme.errorAccentColor)
    //.copyWith(color: kPresentTheme.defaultAccentColor)
      if(laggingGoals > 0 && laggingGoals> leadingGoals){
        recomMessage = '${DefaultValues.recom_summary['negative']}';
        displayWidget = Text(recomMessage,);
      }else{
        recomMessage = '${DefaultValues.recom_summary['positive']}';
        displayWidget = Text(recomMessage, );
      }


    }


   }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(() {

      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){


        setState(() {
          _scrollingUp = false;
          _showSummary = false;
        });
      } else if(_scrollController.position == _scrollController.position.minScrollExtent){


        setState(() {
          _scrollingUp = true;
          _showSummary = true;
        });
      }

    });
  }
  @override
  Widget build(BuildContext context) {


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

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 1,color: kPresentTheme.alternateColor),
                  ),
                  Container(
                    height: DefaultValues.screenHeight(context)/2,
                    child: ListView.builder(

                        itemCount: widget.dataSet[0].length-1,

                        itemBuilder: (context, index){

                      return Shingle(
                          textDisplayScale: 0.9,
                          icon1: null,
                          leadingImage: (double.parse( widget.dataSet[3][index+1])>0)?this.positiveIcon:negativeIcon,
                          type: 'goal',
                          title: double.parse( widget.dataSet[3][index+1])>0 ? '${DefaultValues.messages['recomm_positive_1']} ${DefaultValues.messages['recomm_2']}'
                          :'${DefaultValues.messages['recomm_negative_1']} ${DefaultValues.messages['recomm_2']}',
                         // title: 'Goals for ${widget.dataSet[0][index+1]}th year is ${double.parse( widget.dataSet[3][index+1])>0 ? 'leading':'lagging'}',
                          subtitle: 'by ${DefaultValues.financialFormat(DefaultValues.textFormatWithDecimal,double.parse( widget.dataSet[3][index+1]))}',
                          onPressed: (){}
                          );
                        }
                      //DefaultValues.financialFormat(DefaultValues.textFormatWithDecimal, widget.dataSet[3][index+1])
                    ),
                  ),
                  //

                ],


            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left : 0.0, bottom: 0.0,top:10.0 ),
            child: Center(
                child: ExpandButton(
                      display: !widget.scrolledUp ? Icon(Icons.keyboard_arrow_up):Icon(Icons.keyboard_arrow_down),
                      color: kPresentTheme.themeColor,
                     onTap: widget.scrollControl,
                    ),

            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:3.h),
            child: Center(child: widget.showHeader ? displayWidget : SizedBox()),
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
