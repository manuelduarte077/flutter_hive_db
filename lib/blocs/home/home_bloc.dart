import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_hive_db/services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _authenticationService;

  HomeBloc(this._authenticationService) : super(const HomeInitial()) {
    on<LoginEvent>((event, emitter) async {
      print('LoginEvent $event');

      final user = await _authenticationService.authenticateUser(
          event.userName, event.password);

      if (user != null) {
        emit(SuccessFullLoginState(user));
      }
    });
  }
}
