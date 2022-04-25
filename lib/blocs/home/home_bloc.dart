import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_hive_db/services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _authenticationService;
  final TodoService _todoService;

  HomeBloc(this._authenticationService, this._todoService)
      : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _authenticationService.authenticateUser(
          event.userName, event.password);

      if (user != null) {
        emit(SuccessFullLoginState(user));
        emit(const HomeInitial());
      }
    });

    on<RegisterAccountUserEvent>((event, emit) async {
      final result = await _authenticationService.createUser(
          event.userName, event.password);

      switch (result) {
        case UserCreationResult.success:
          emit(SuccessFullLoginState(event.userName));
          break;
        case UserCreationResult.failure:
          emit(
              const HomeInitial(error: 'There was an error creating the user'));
          break;
        case UserCreationResult.alreadyExists:
          emit(const HomeInitial(
              error: 'The user already exists, please login instead'));
          break;
      }
    });

    on<RegisterServicesEvent>((event, emit) async {
      await _authenticationService.init();
      await _todoService.init();

      emit(const HomeInitial());
    });
  }
}
