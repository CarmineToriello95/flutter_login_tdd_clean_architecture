import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';

abstract class LoginLocalDataSource {
  Future<void> cacheUser(User user);
}
