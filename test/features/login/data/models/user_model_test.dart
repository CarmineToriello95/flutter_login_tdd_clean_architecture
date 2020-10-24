import 'dart:convert';

import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUser = UserModel(sessionId: '1603447040818');

  test('should be a subclass of User entity', () async {
    // assert
    expect(tUser, isA<User>());
  });

  test('should return a valid model from the JSON', () async {
    // assert
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('login_api_response.json'));
    // act
    final result = UserModel.fromJson(jsonMap);
    // assert
    expect(result, tUser);
  });
}
