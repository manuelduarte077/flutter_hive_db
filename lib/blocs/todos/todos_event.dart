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
