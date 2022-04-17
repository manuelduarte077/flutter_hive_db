import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_db/blocs/blocs.dart';
import 'package:flutter_hive_db/services/services.dart';

class TodosScreen extends StatelessWidget {
  final String userName;

  const TodosScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  static const String routeName = '/todos';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TodosScreen(userName: ''),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(userName)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                  children: state.tasks
                      .map((e) => ListTile(
                            title: Text(e.task),
                            subtitle: Text(e.description),
                            trailing: Checkbox(
                              value: e.completed,
                              onChanged: (val) {},
                            ),
                          ))
                      .toList());
            }

            return Container();
          },
        ),
      ),
    );
  }
}
