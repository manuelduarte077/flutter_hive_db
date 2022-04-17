part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoginEvent extends HomeEvent {
  final String userName;
  final String password;

  const LoginEvent(
    this.userName,
    this.password,
  );

  @override
  List<Object?> get props => [userName, password];
}
