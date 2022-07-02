import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habits/app/App.dart';
import 'package:habits/app/DayDB.dart';
import 'package:habits/app/HabitsDB.dart';
import 'package:habits/appUtils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';


/* *************************************************************************
 Classes for page where you can add/edit project with description 
************************************************************************* */
class AddHabitPage extends StatefulWidget {
  final mode;
  final name;
  final color;

  AddHabitPage(this.mode, {this.name = '', this.color = ''});
  
  @override
  AddHabitPageState createState() => AddHabitPageState();
}


class AddHabitPageState extends State<AddHabitPage>{
  var habits_box;
  var boxSize;
  var habitColor;
  var habitAlarm;

  Map<String, Object> fieldValues = {
    'name': '',
    'measureUnit': '',
    'eveyDayAim': '',
    'notes': '',
    'frequency': '',
    'alarm': false,
    'color': (Color.fromARGB(255, 55, 80, 47)).value,
  };
  
  var textFieldWidth = 320.0;


  // Function for getting data from Hive database
  getDataFromBox() async {
    habits_box = await Hive.openBox('habits');
    boxSize = habits_box.length;

    return Future.value(habits_box.values);      
  }  


  // Function for adding data to database
  void addToBox() {

    habits_box.put(
      'habit${boxSize?? 0}', 
      HabitData(
        fieldValues['name'], 
        fieldValues['measureUnit'], 
        fieldValues['eveyDayAim'], 
        [DayData(DateTime.now().toString())],

        alarm: fieldValues['alarm'],
        frequency: fieldValues['frequency'],
        notes: fieldValues['notes'], 
        color: fieldValues['color'],
      )
    );

  }


    // Function for adding data to database
  void changeInBox() {
    for (var key in habits_box.keys) {
      if ((habits_box.get(key)).name == widget.name) {
        habits_box.put(
          key, 
          HabitData(
            widget.name, 
            fieldValues['measureUnit'] == ''? (habits_box.get(key)).measureUnit : fieldValues['measureUnit'], 
            fieldValues['eveyDayAim'] == ''? (habits_box.get(key)).eveyDayAim: fieldValues['eveyDayAim'], 
            (habits_box.get(key)).days,

            alarm: habitAlarm == null? (habits_box.get(key)).alarm : fieldValues['alarm'],
            frequency: fieldValues['frequency'] == ''? (habits_box.get(key)).frequency : fieldValues['frequency'],
            notes: fieldValues['notes'] == ''? (habits_box.get(key)).notes : fieldValues['notes'], 
            color: habitColor == null? (habits_box.get(key)).color : fieldValues['color'],
          )
        );
      }      
    }

  }


  // Redirect to page with list of wells
  void redirect() {
    Navigator.pop(context, false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => App()));
  }


  

  // Create textField block for input
  Widget textFieldForAdd() {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Text field block for project name and number
          Padding(
            padding: EdgeInsets.fromLTRB(9, 8, 9, 2),
            child: Column(
              children: [

                textField(
                  TextInputAction.next, 
                  'Name...',
                  null, null,
                  TextInputType.text, 
                  null,
                  String,
                  width: textFieldWidth,
                  inputValueIndex: 'name'
                ),

                SizedBox(height: 8),

                textField(
                  TextInputAction.next, 
                  'Measure unit...', 
                  null, null,
                  TextInputType.text, 
                  null,
                  String,
                  width: textFieldWidth,
                  inputValueIndex: 'measureUnit'
                ),

                SizedBox(height: 8),
                
                textField(
                  TextInputAction.next, 
                  'Aim...', 
                  null, null,
                  TextInputType.text, 
                  null,
                  String,
                  width: textFieldWidth,
                  inputValueIndex: 'eveyDayAim'
                ),

                SizedBox(height: 8),

                textField(
                  TextInputAction.newline, 
                  'Notes...', 
                  null, null,
                  TextInputType.multiline, 
                  null,
                  String,
                  width: textFieldWidth,
                  inputValueIndex: 'notes'
                ),

                SizedBox(height: 8),

                textField(
                  TextInputAction.done, 
                  'Frequency...', 
                  null, null,
                  TextInputType.text, 
                  null,
                  String,
                  width: textFieldWidth,
                  inputValueIndex: 'frequency'
                ),
                

                SizedBox(height: 8),

                Row(
                  children: [
                    Text(" Alarm", style: TextStyle(fontSize: 12, color: Colors.grey.shade400)), 

                    SizedBox(
                      width: 60,
                      child:  Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: fieldValues['alarm'] as bool, 
                          onChanged: (value) {
                            setState(() {
                              fieldValues['alarm'] = value;  
                              habitAlarm = value;
                            });
                          }
                        ),
                      ),
                    ),

                    SizedBox(width: 20),

                    button(functions: [widget.mode == 'add'? addToBox : changeInBox, redirect], text: widget.mode == 'add'? "Add" : "Edit"),

                    SizedBox(width: 40),

                    ElevatedButton(
                      child: Container(
                        color: Color(fieldValues['color'] as int),
                        height: 20,
                        width: 25
                      ),

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(30.0, 30.0),
                        primary: Color.fromARGB(222, 132, 132, 132), 
                        textStyle: TextStyle(color: Colors.white, fontSize: 14.0),
                        side: BorderSide(color: Colors.black45, width: 1.0),
                        shadowColor: Color.fromARGB(218, 0, 0, 0), 
                        surfaceTintColor: Color.fromARGB(218, 0, 0, 0), 
                      ),
                      
                      onPressed: () =>
                        showDialog(
                          context: context,
                          builder: (BuildContext context) { 
                            return AlertDialog(
                              backgroundColor: Color.fromARGB(212, 255, 255, 255),
                              content: ColorPicker(
                                pickerColor: Color(fieldValues['color'] as int),
                                onColorChanged: (Color color) {
                                  fieldValues['color'] = color.value;
                                  habitColor = color.value;
                                  setState(() {});
                                }
                              ),
                            
                            );
                          }
                        )
                      
                    ),

                  ],
                ),
                           
              ]
            )
          ),    
        ]
      );
  }


  // Text fields with button for adding new project
  Widget addProjectTextField() {
    
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          textFieldForAdd(),
        ],
      ),
    );
  }


  // Text fields with button for editing project
  Widget changeProjectTextField() {

    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          textFieldForAdd(),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    var boxData = getDataFromBox();


    return  Scaffold(

              backgroundColor: Color.fromARGB(255, 49, 49, 49),
              
              appBar: AppBar(
                backgroundColor: Color.fromARGB(163, 0, 0, 0), 
                title: Text(widget.mode == 'add'? 'Create new habit' : 'Edit habit'),
                automaticallyImplyLeading: false
              ),

              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // create text fields for add/edit, depending on page, where you're in
                      if (widget.mode == 'add') addProjectTextField(),
                      if (widget.mode == 'edit' && widget.name!='') changeProjectTextField(),
                    
                    ],
                  ),
                ),
              ),
              
            );
  }


  // Create text field with parameters
  Widget textField(
    TextInputAction? textInputAction, String? labelText, 
    TextStyle? hintStyle, TextStyle? labelStyle, TextInputType? keyboardType, 
    TextInputFormatter? inputFormatters, Type? parseType,
    {double? width, double? height, String inputValueIndex = ''}
  ) {
    return Container(
      width: width,

      child: TextFormField(
        autofocus: false,
        textInputAction: textInputAction,

        keyboardType: keyboardType,
        inputFormatters: [
          if (inputFormatters != null) inputFormatters
        ],

        maxLines: (inputValueIndex == 'notes')? null : 1,

        autocorrect: true,
        enableSuggestions: true,

        cursorRadius: const Radius.circular(10.0),
        cursorColor: Color.fromARGB(255, 233, 233, 233),

        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: TextStyle( fontSize: 12, color: Colors.grey.shade400),
          labelStyle: TextStyle( fontSize: 12, color: Colors.grey.shade400),

          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          
          focusedBorder: textFieldStyle,
          enabledBorder: textFieldStyle,
        ),
        
        onChanged: (String value) { 
          if (parseType == double) {
            fieldValues[inputValueIndex] = double.tryParse(value) == null? 0.0 : double.parse(value);
          } else if (parseType == int) {
            fieldValues[inputValueIndex] = int.tryParse(value) == null? 0: int.parse(value);
          } else {
            fieldValues[inputValueIndex] = value;
          }
        }

      )
    );
  }
  
}