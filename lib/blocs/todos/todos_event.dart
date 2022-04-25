part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String userName;

  const LoadTodosEvent(this.userName);

  @override
  List<Object> get props => [userName];
}

class AddTodoEvent extends TodosEvent {
  final String taskText;
  final String descriptionText;

  const AddTodoEvent(this.taskText, this.descriptionText);

  @override
  List<Object> get props => [taskText, descriptionText];
}
