part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final String? error;

  const HomeInitial({this.error});

  @override
  List<Object?> get props => [error];
}

class SuccessFullLoginState extends HomeState {
  final String userName;

  const SuccessFullLoginState(this.userName);
  @override
  List<Object?> get props => [userName];
}

class RegisteringServicesState extends HomeState {
  @override
  List<Object?> get props => [];
}
