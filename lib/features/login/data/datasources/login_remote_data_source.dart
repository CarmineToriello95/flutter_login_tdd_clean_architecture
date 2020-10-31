import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';

abstract class LoginRemoteDataSource {
  /// Calls the https://petstore.swagger.io/#/user/loginUser endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> login(String email, String password);
}
