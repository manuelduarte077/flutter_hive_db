import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_db/routes/app_route.dart';
import 'package:flutter_hive_db/screens/screens.dart';
import 'package:flutter_hive_db/services/authentication.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationService>(
          create: (context) => AuthenticationService(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
