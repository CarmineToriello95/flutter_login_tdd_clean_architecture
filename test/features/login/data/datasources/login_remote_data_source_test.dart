import 'dart:convert';

import 'package:flutter_login_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_local_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  LoginRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('login', () {
    final tEmail = 'test';
    final tPassword = '123456';
    final expectedUri =
        'https://www.petstore.swagger.io/v2/user/login?username=test&password=123456';
    final tUserModel =
        UserModel.fromJson(jsonDecode(fixture('login_api_response.json')));

    test('''should perform a GET request on a URL with login 
    being the endpoint, tEmail and tPassword as query parameters 
    and with application/json header ''', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('login_api_response.json'), 200));
      // act
      dataSource.login(tEmail, tPassword);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(expectedUri),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return User when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('login_api_response.json'), 200));
      // act
      final result = await dataSource.login(tEmail, tPassword);
      // assert
      expect(result, equals(tUserModel));
    });

    test(
        'should return a ServerException when the response code is 404 or other (unsuccess)',
        () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.login;
      // assert
      expect(() => call(tEmail, tPassword), throwsA(isA<ServerException>()));
    });
  });
}
