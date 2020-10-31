import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';

abstract class LoginLocalDataSource {
  Future<void> cacheUser(UserModel user);
}
