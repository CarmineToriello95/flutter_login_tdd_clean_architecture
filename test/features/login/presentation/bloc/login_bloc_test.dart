import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_login_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/presentation/bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

void main() {
  LoginBloc bloc;
  MockLoginUsecase mockLoginUsecase;

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    bloc = LoginBloc(loginUsecase: mockLoginUsecase);
  });

  tearDown(() {
    bloc.close();
  });

  group('login', () {
    final tEmail = 'test';
    final tPassword = '123456';
    final tUser = User(sessionId: '1029384756');

    test('the initial state should be Initial when no events have been added',
        () {
      expect(bloc.state, Initial());
    });

    blocTest(
      'emits [Loading, Loaded(User)] when data is gotten successfully',
      build: () {
        when(mockLoginUsecase(any)).thenAnswer((_) async => Right(tUser));
        return LoginBloc(loginUsecase: mockLoginUsecase);
      },
      act: (bloc) async {
        bloc.add(SubmitLogin(email: tEmail, password: tPassword));
      },
      expect: [Loading(), Loaded(user: tUser)],
    );

    blocTest(
      'emits [Loading, Error(message: SERVER_FAILURE_MESSAGE)] when getting data fails',
      build: () {
        when(mockLoginUsecase(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return LoginBloc(loginUsecase: mockLoginUsecase);
      },
      act: (bloc) async {
        bloc.add(SubmitLogin(email: tEmail, password: tPassword));
      },
      expect: [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'emits [Loading, Error(message: NETWORK_FAILURE_MESSAGE)] when there is no internet connection',
      build: () {
        when(mockLoginUsecase(any))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return LoginBloc(loginUsecase: mockLoginUsecase);
      },
      act: (bloc) async {
        bloc.add(SubmitLogin(email: tEmail, password: tPassword));
      },
      expect: [Loading(), Error(message: NETWORK_FAILURE_MESSAGE)],
    );
  });
}
