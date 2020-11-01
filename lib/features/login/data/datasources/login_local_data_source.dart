import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<void> cacheUser(UserModel user);
}

const CACHED_USER = 'CACHED_USER';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return sharedPreferences.setString(
      CACHED_USER,
      jsonEncode(userToCache.toJson()),
    );
  }
}
