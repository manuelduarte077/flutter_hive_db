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

class RegisterServicesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RegisterAccountUserEvent extends HomeEvent {
  final String userName;
  final String password;

  RegisterAccountUserEvent(this.userName, this.password);

  @override
  List<Object?> get props => [userName, password];
}
