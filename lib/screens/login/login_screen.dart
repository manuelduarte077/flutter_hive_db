import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_db/blocs/blocs.dart';
import 'package:flutter_hive_db/screens/screens.dart';
import 'package:flutter_hive_db/services/services.dart';

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
      appBar: AppBar(
        title: const Text('Login'),
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
            },
            builder: (context, state) {
              if (state is HomeInitial) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    TextField(
                      controller: userNameField,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      controller: passwordField,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LoginEvent(
                                  userNameField.text, passwordField.text)),
                          child: const Text('Login'),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Register')),
                      ],
                    ),
                  ],
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
