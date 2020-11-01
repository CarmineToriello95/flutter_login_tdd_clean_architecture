import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_login_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  /// Calls the https://petstore.swagger.io/#/user/loginUser endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final Map<String, String> queryParameters = {
      'username': email,
      'password': password,
    };
    final uri =
        Uri.https('www.petstore.swagger.io', '/v2/user/login', queryParameters);
    final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
