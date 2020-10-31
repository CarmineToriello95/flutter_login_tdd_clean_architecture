import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  /// Calls the https://petstore.swagger.io/#/user/loginUser endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String email, String password);
}
