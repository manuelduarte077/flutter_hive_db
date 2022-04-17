part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

class SuccessFullLoginState extends HomeState {
  final String userName;

  const SuccessFullLoginState(this.userName);
  @override
  List<Object?> get props => [userName];
}
