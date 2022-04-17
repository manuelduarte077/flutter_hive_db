import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_hive_db/models/models.dart';
import 'package:flutter_hive_db/services/services.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;
  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      print('LoadTodosEvent $event');

      final todos = _todoService.getTask(event.userName);
      emit(TodosLoadedState(todos));
    });
  }
}
