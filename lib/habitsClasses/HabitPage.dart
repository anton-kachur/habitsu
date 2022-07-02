import 'package:flutter/material.dart';
import 'package:habits/app/AddHabitPage.dart';
import 'package:habits/app/DayDB.dart';
import 'package:habits/app/HabitsDB.dart';
import 'package:habits/appUtils.dart';
import 'package:habits/habitsClasses/HabitBlock.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HabitPage extends StatefulWidget {
  var habitData;

  HabitPage(this.habitData);

  @override
  State<HabitPage> createState() => _HabitPageState();
}


class _HabitPageState extends State<HabitPage> {
  Map<String, Object> fieldValues = {
    'name': '',
    'measureUnit': '',
    'eveyDayAim': '',
    'notes': '',
    'frequency': '',
    'alarm': '',
    'color': Colors.black,
  };


  var habits_box;
  var boxSize;

  var textFieldWidth = 320.0;


  // Function for getting data from Hive database
  getDataFromBox() async {
    habits_box = await Hive.openBox('habits');
    boxSize = habits_box.length;

    return Future.value(habits_box.values);      
  }  


  // Function for adding data to database
  /*void addToBox() {

    habits_box.put(
      'habit${boxSize?? 0}', 
      HabitData(
        fieldValues['name'], 
        fieldValues['measureUnit'], 
        fieldValues['everyDayAim'], 
        [DayData(DateTime.now().toString())],

        alarm: fieldValues['alarm'],
        frequency: fieldValues['frequency'],
        notes: fieldValues['notes'], 
        color: fieldValues['color'],
      )
    );

  }*/


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
            return Scaffold(
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
      
              appBar: AppBar(
                title: Text("${widget.habitData['name']}"),
                backgroundColor: Color.fromARGB(163, 0, 0, 0),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 22.0),
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddHabitPage('add')));
                    }, 
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, size: 22.0),
                    onPressed: () {
                      
                    }, 
                  ),

                  IconButton(
                    icon: const Icon(Icons.share, size: 22.0),
                    onPressed: () {
                      
                    }, 
                  )

                ],
              ),
              
              body: Scrollbar(
                child: SingleChildScrollView (
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var entry in widget.habitData.entries)
                        if (entry.key != 'days')
                          Text("${entry.key}: ${entry.value}")
                        else
                          for (var day in entry.value)
                            Text("${day.date} -> ${day.todayResult}")
                      /*if (snapshot.data != null)
                        for (var element in snapshot.data)
                          HabitBlock(
                            element.name, element.measureUnit, element.eveyDayAim, element.notes, 
                            element.frequency, element.alarm, element.color, element.days
                          )
                      else 
                        HabitBlock(),*/
                    ],
                  ),
                ),
              ),
            );
          }
          }
      }
    );
  }
  
}
