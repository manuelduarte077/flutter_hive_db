import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_db/blocs/blocs.dart';
import 'package:flutter_hive_db/services/services.dart';

class TodosScreen extends StatelessWidget {
  final String? userName;

  const TodosScreen({
    Key? key,
    this.userName,
  }) : super(key: key);

  static const String routeName = '/todos';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TodosScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(userName!)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(children: [
                ...state.tasks.map(
                  (e) => ListTile(
                    title: Text(e.task),
                    subtitle: Text(e.description),
                    trailing: Checkbox(
                      value: e.completed,
                      onChanged: (val) {},
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Add new task',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    final result = await showDialog<String>(
                        context: context,
                        builder: (_) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              insetAnimationCurve: Curves.easeInOut,
                              elevation: 50,
                              child: CreateNewTask(),
                            ));

                    if (result != null) {
                      BlocProvider.of<TodosBloc>(context)
                          .add(AddTodoEvent(result, userName!));
                    }
                  },
                  trailing: const Icon(Icons.create_outlined),
                )
              ]);
            }
            return const Text('Loading...');
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            const Text(
              "Create new task",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Add task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
