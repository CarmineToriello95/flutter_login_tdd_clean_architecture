import 'package:flutter_login_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/repositories/login_repository_impl.dart';
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
}
