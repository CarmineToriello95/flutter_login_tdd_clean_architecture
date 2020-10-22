import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_tdd_clean_architecture/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUsecase implements UseCase<User, Params> {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.login(params.email, params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({@required this.email, @required this.password});
}
