import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'DayDB.g.dart';

@HiveType(typeId: 1)
class DayData {
  @HiveField(0)
  var date;
  @HiveField(1)
  var todayResult;

  DayData(this.date, {this.todayResult});
}