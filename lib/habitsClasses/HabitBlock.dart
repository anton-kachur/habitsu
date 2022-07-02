import 'package:flutter/material.dart';
import 'package:habits/app/AddHabitPage.dart';
import 'package:habits/appUtils.dart';
import 'package:habits/habitsClasses/HabitPage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';


class HabitBlock extends StatefulWidget {
  final name;
  final measureUnit;
  final eveyDayAim;
  final notes;
  final frequency;
  final alarm;
  final color;
  final days;
  
  HabitBlock(
    this.name, this.measureUnit, this.eveyDayAim, this.notes, 
    this.frequency, this.alarm, this.color, this.days
  );

  toJSON() => {
    'name': name, 'measureUnit': measureUnit, 
    'eveyDayAim': eveyDayAim, 'notes': notes, 
    'frequency': frequency, 'alarm': alarm, 
    'color': color, 'days': days
  };

  @override
  _HabitBlockState createState() => _HabitBlockState();
}


class _HabitBlockState extends State<HabitBlock>{
  var habit_box;

  // Function for getting data from Hive database
  Future getDataFromBox() async {
    habit_box = await Hive.openBox('habits');
    
    return Future.value(habit_box.values);     
  }

  @override
  Widget build(BuildContext context) {

    var boxData = getDataFromBox();

    return FutureBuilder(
      future: boxData,  // data retreived from database
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingOrErrorWindow('Loading...', context);
        } else {
          if (snapshot.hasError) {
            return waitingOrErrorWindow('Error: ${snapshot.error}', context);
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(widget.color),
                      Color.fromARGB(218, 0, 0, 0), 
                    ]
                  )
                ),

                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${widget.name}\naim: ${widget.eveyDayAim} ${widget.measureUnit}/day')
                      ),
                      
                      /*for (var element in widget.days) 
                        Container(width: 10, height: 10, color: Color(int.parse(widget.color))),*/


                      CircularPercentIndicator(
                        radius: 20.0,
                        lineWidth: 5.0,
                        animation: true,
                        percent: 0.8,
                        center: Text("${0.7 * 100}%", style: TextStyle(fontSize: 8, color: Color.fromARGB(255, 203, 203, 203))),
                        circularStrokeCap: CircularStrokeCap.butt,
                        progressColor: Colors.white70,
                        backgroundColor: Color.fromARGB(10, 255, 255, 255),
                      ),

                    ]
                  ),
                  
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(320, 100),
                    primary: Colors.transparent,
                    textStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                    side: BorderSide(color: Colors.black45, width: 1.0),
                    shadowColor: Colors.transparent, 
                    surfaceTintColor: Colors.transparent, 
                  ),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HabitPage(widget.toJSON())));
                  },

                  onLongPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddHabitPage('edit', name: widget.name, color: widget.color)));
                  } 
                ),
              )
            );
          }
        }
      }
    );
  }
}