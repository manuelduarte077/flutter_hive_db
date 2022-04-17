import 'package:flutter/material.dart';
import 'package:flutter_hive_db/app/app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}
