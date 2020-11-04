import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({@required this.loginUsecase}) : super(Initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SubmitLogin) {
      yield Loading();
      final failureOrUser = await loginUsecase(
          Params(email: event.email, password: event.password));
      yield* failureOrUser.fold(
        (failure) async* {
          yield Error(message: _mapFailureToMessage(failure));
        },
        (user) async* {
          yield Loaded(user: user);
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
