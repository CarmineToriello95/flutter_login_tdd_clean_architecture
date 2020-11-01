import 'dart:convert';

import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LoginLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        LoginLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cacheUser', () {
    final tUserModel = UserModel(sessionId: '1603447040818');

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheUser(tUserModel);
      // assert
      final expectedJsonString = jsonEncode(tUserModel.toJson());
      verify(mockSharedPreferences.setString(CACHED_USER, expectedJsonString));
    });
  });
}
