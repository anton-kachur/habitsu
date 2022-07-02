import 'package:flutter/material.dart';
import 'package:habits/app/DayDB.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'HabitsDB.g.dart';

@HiveType(typeId: 0)
class HabitData {
  @HiveField(0)
  var name;
  @HiveField(1)
  var measureUnit;
  @HiveField(2)
  var eveyDayAim;
  @HiveField(3)
  var notes;
  @HiveField(4)
  var frequency;
  @HiveField(5)
  var alarm;
  @HiveField(6)
  var color;
  @HiveField(7)
  List<DayData> days;

  HabitData(
    this.name, this.measureUnit, this.eveyDayAim, this.days,
    {this.alarm = false, this.frequency = "Every day", this.notes = "", this.color = 0x12345678}
  );
}