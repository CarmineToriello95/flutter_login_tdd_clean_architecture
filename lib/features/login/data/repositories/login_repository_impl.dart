import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    @required this.loginRemoteDataSource,
    @required this.loginLocalDataSource,
    @required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, User>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
