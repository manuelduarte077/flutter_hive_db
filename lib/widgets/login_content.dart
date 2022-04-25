import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hive_db/blocs/blocs.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    Key? key,
    required this.userNameField,
    required this.passwordField,
  }) : super(key: key);

  final TextEditingController userNameField;
  final TextEditingController passwordField;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://avatars3.githubusercontent.com/u/17098981?s=460&u=f9f8b8d8f9f8b8d8f9f8b8d8f9f8b8d8f9f8b8d&v=4',
          ),
        ),
        const SizedBox(height: 55),
        const Text(
          'Login',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextField(
          controller: userNameField,
          decoration: const InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          controller: passwordField,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 55),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                LoginEvent(userNameField.text, passwordField.text),
              ),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                RegisterAccountUserEvent(
                    userNameField.text, passwordField.text),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ],
    );
  }
}
