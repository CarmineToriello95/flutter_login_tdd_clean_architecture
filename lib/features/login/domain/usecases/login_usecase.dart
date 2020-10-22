import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, User>> execute({
    @required String email,
    @required String password,
  }) async {
    return await repository.login(email, password);
  }
}
