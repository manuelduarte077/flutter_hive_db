import 'package:flutter/material.dart';

import 'package:flutter_hive_db/routes/app_route.dart';
import 'package:flutter_hive_db/screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
