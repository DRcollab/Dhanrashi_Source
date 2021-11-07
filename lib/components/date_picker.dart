import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';



class Calendar extends StatefulWidget {

  DateTime initialDate;
  Function(DateTime dateValue) onDateChanged;
  Color backColor;
  Color selectColor;
  Color cellColor;
  Color headerColor;
  DateTime? firstDate;
  DateTime? lastDate;
  Color selectTextColor;
  Color textColor;
  List<GlobalKey?>? showCaseKeys;

  Calendar({
    required this.initialDate,
    required this.onDateChanged,
    this.backColor =const Color(0x00000000),
    this.selectColor = const Color(0xff123458),
    this.cellColor = const Color(0x00000000),
    this.headerColor = const Color(0x00000000),
    this.selectTextColor = const Color(0xffffffff),
    this.textColor = const Color(0x00000000),
    this.firstDate,
    this.lastDate,
    this.showCaseKeys,
  });




  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  List arrayOfDates = [];
  Color selectedColor = Colors.blueGrey;
  int selectedCell = -1;
  bool showingMonthsGrid = false;
  bool showingYearsGrid = false;
  int selectedMonth = 0;
  int selectedYear = 0;
  int selectedDay = 0;
  bool showingDays = true;
  late int startYear;
  late int lastYear;


  late DateTime selectedDate;

  late Widget  selectedGrid = showDays();

  List<String> months = [ 'Jan','Feb', 'Mar','Apr','May', 'Jun','Jul','Aug','Sep','Oct',
    'Nov', 'Dec',

  ];

  List<int> maxDays = [ 31,28,31,30,31,30,31,31, 30,31, 30, 31,];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startYear = (widget.firstDate !=null) ? widget.firstDate!.year:1900 ;
    lastYear = (widget.lastDate !=null) ?widget.lastDate!.year: DateTime.now().year;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
    selectedDay = widget.initialDate.day;
    arrayOfDates = determineDateList();
    selectedDate = DateTime(selectedYear,selectedMonth,selectedDay);
    selectedGrid = showDays();
    selectedColor = widget.selectColor;

    // print(selectedMonth);
  }


  Widget showYears(){
    showingDays = false;

   // ScrollController _scroller = ScrollController();
    //_scroller.jumpTo(_scroller.position.maxScrollExtent);
    return  Container(

      child: GridView.builder(
          padding:const EdgeInsets.all(8.0) ,
          shrinkWrap: true,
          itemCount: lastYear - startYear+1,
          scrollDirection:Axis.vertical,
          //controller: _scroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,


          ),
          itemBuilder: (BuildContext context, int index){

            return GestureDetector(
              onTap: (){
                setState(() {
                  selectedCell = index;
                  selectedYear = startYear+index;
                  arrayOfDates = determineDateList();
                  selectedGrid = showDays();
                  showingYearsGrid = false;
                  selectedCell = arrayOfDates.indexOf(selectedDay);
                });

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (index==selectedCell) ?selectedColor :widget.cellColor,
                  ),

                  child: Center(
                    child: Text((startYear+index).toString(),style:TextStyle(
                      fontWeight: FontWeight.bold,color: (index==selectedCell) ?widget.selectTextColor:widget.textColor,
                    ),),
                  ),
                ),
              ),
            );

          }),
    );
  }


  Widget showDays(){
    showingDays = true;
   // selectedCell = arrayOfDates.indexOf(selectedDay);
    return  GridView.builder(
        itemCount: arrayOfDates.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (BuildContext context, int index){

          return GestureDetector(
            onTap: (){
              setState(() {

                selectedCell = index;
                selectedDay = int.parse(arrayOfDates[index]);
                selectedGrid = showDays();
                DateTime dt = DateTime(selectedYear,selectedMonth,selectedDay);
                widget.onDateChanged(dt);
              });

            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: (index==selectedCell) ? widget.selectColor :widget.cellColor,
                ),

                child: Center(
                  child: Text(arrayOfDates[index],style: TextStyle(
                    fontWeight: FontWeight.bold,color: (index==selectedCell) ? widget.selectTextColor:widget.textColor,
                  ),),
                ),
              ),
            ),
          );

        });
  }

  Widget showMonths(){
    showingDays = false;


    return  Padding(
      padding:  EdgeInsets.only(left: 3.5.w,right: 3.5.w),
      child: GridView.builder(

          itemCount: months.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,

          ),
          itemBuilder: (BuildContext context, int index){
            //print(widget.initialDate.weekday);
            return GestureDetector(
              onTap: (){
                setState(() {
                  // selectedCell = index;
                  showingMonthsGrid = false;
                  selectedMonth = months.indexOf(months[index])+1;
                  arrayOfDates = determineDateList();
                  selectedGrid = showDays();
                  selectedCell = arrayOfDates.indexOf(selectedDay);
                });

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (index==selectedCell) ? widget.selectColor :widget.cellColor,
                  ),

                  child: Center(
                    child: Text(months[index],style: TextStyle(
                      fontWeight: FontWeight.bold,color:(index==selectedCell) ?widget.selectTextColor :widget.textColor,
                    ),),
                  ),
                ),
              ),
            );

          }),
    );
  }

  List determineDateList(){
    List dates = List.empty(growable: true);
    DateTime d = DateTime(selectedYear,selectedMonth,1);

    for(int i=0;i<(d.weekday-1)%6;i++){
      dates.add('');
    }
    for(int i = 1;i<=maxDays[selectedMonth-1]; i++){
      dates.add(i.toString());
    }
    return dates;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left:1.h,top:8,bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: widget.headerColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Showcase(
                  key:widget.showCaseKeys![0],
                  description: 'Reduce the month',
                  child: IconButton(
                      onPressed: (){
                        setState(() {
                          if(selectedMonth>1)
                            {
                              selectedMonth--;
                            }else{
                            selectedMonth=12;
                            selectedYear--;
                          }

                        });

                      },
                      icon:const Icon(Icons.arrow_left,size: 28,)),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(!showingMonthsGrid){
                        selectedGrid = showMonths();
                        showingMonthsGrid = true;
                        showingDays = false;
                        showingMonthsGrid = true;
                      }else{
                        selectedGrid = showDays();
                        showingMonthsGrid = false;
                      }

                    });
                  },
                  child: Showcase(
                    key: widget.showCaseKeys![1],
                    description:'Click here to get the month list',
                    child: Text(months[selectedMonth-1],

                      style:  TextStyle(
                        fontSize: 18.sp,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Showcase(
                  key: widget.showCaseKeys![2],
                  description: 'Increase the month by 1',
                  child: IconButton(
                      onPressed: (){
                        setState(() {
                          if(selectedMonth<12){
                            selectedMonth++;
                          }else{
                            selectedMonth = 1;
                            selectedYear++;
                          }

                        });

                      },
                      icon:const Icon(Icons.arrow_right,size: 28,)),
                ),
                Container(width: 3,height: 30,color: Colors.black12,),
                IconButton(
                    onPressed: (){
                      setState(() {
                        selectedYear--;
                      });

                    },
                    icon:const Icon(Icons.arrow_left,size: 28,)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(!showingYearsGrid) {
                        selectedGrid = showYears();
                        showingMonthsGrid = false;
                        showingDays = false;
                        showingYearsGrid = true;
                        selectedCell = -1;
                      }else{
                        selectedGrid = showDays();
                        showingYearsGrid = false;
                      }

                    });
                  },
                  child: Showcase(
                    key:widget.showCaseKeys![3],
                    description:'Click here to get the year list',
                    child: Text(selectedYear.toString(), style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),),
                  ),
                ),
                IconButton(
                    onPressed: (){
                        setState(() {
                          selectedYear++;
                        });
                    },
                    icon:Icon(Icons.arrow_right,size: 28,)),
              ],
            ),
          ),
        ),
        showingDays ? Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Text('Mon',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Tue',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Wed',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Thu',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Fri',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Sat',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Sun',style: TextStyle(color: widget.cellColor,fontWeight: FontWeight.bold),),

          ],
        ):const SizedBox(height: 1,),
        Padding(
          padding: const EdgeInsets.only(left:10.0,top: 10,right: 10,bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.backColor,
              //backgroundBlendMode: BlendMode.overlay,
            ),
            height: 36.h,
            child:Showcase(
                key:widget.showCaseKeys![4],
                description: 'Select from this grid by clicking on them',
                child: selectedGrid),
          ),
        ),

      ],
    );
  }
}
