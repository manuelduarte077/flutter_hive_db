import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hive_db/blocs/blocs.dart';
import 'package:flutter_hive_db/screens/screens.dart';
import 'package:flutter_hive_db/services/services.dart';
import 'package:flutter_hive_db/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  final userNameField = TextEditingController();
  final passwordField = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is SuccessFullLoginState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TodosScreen(userName: state.userName),
                  ),
                );
              }

              if (state is HomeInitial) {
                if (state.error != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error',
                          style: TextStyle(color: Colors.red)),
                      content: Text(state.error!,
                          style: const TextStyle(color: Colors.red)),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is HomeInitial) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: LoginContent(
                    userNameField: userNameField,
                    passwordField: passwordField,
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ),
      ),
    );
  }
}
