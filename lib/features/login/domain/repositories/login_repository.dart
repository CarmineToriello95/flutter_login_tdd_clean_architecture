import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
