import 'package:dartz/dartz.dart';
import 'package:flutter_login_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_login_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_login_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/repositories/login_repository_impl.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/repositories/login_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('login', () {
    final tEmail = 'test@test.com';
    final tPassword = '123456';
    final tUserModel = UserModel(sessionId: '1603447040818');
    final User tUser = tUserModel;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.login(tEmail, tPassword);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.login(tEmail, tPassword))
            .thenAnswer((realInvocation) async => tUserModel);
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verify(mockRemoteDataSource.login(tEmail, tPassword));
        expect(result, equals(Right(tUser)));
      });

      test(
          'should cache the user data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.login(tEmail, tPassword))
            .thenAnswer((realInvocation) async => tUserModel);
        // act
        await repository.login(tEmail, tPassword);
        // assert
        verify(mockRemoteDataSource.login(tEmail, tPassword));
        verify(mockLocalDataSource.cacheUser(tUserModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.login(tEmail, tPassword))
            .thenThrow(ServerException());
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verify(mockRemoteDataSource.login(tEmail, tPassword));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      test('should return network failure when there is no internet connection',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });
}
