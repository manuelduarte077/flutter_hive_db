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
    on<LoginEvent>((event, emitter) async {
      final user = await _authenticationService.authenticateUser(
          event.userName, event.password);

      if (user != null) {
        emit(SuccessFullLoginState(user));
        emit(const HomeInitial());
      }
    });

    on<RegisterServicesEvent>((event, emitter) async {
      await _authenticationService.init();
      await _todoService.init();

      emit(const HomeInitial());
    });
  }
}
