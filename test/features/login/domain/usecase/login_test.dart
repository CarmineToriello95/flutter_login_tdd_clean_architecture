import 'package:dartz/dartz.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/repositories/login_repository.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/usecases/login_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginUsecase loginUsecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginUsecase = LoginUsecase(mockLoginRepository);
  });

  final tEmail = 'test@test.com';
  final tPassword = '123456';
  final tUser = User(sessionId: '192837465');

  test('should get user session id from the repository', () async {
    // arrange
    when(mockLoginRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => Right(tUser));
    // act
    final result =
        await loginUsecase.execute(email: tEmail, password: tPassword);
    // assert
    expect(result, Right(tUser));
    verify(mockLoginRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
