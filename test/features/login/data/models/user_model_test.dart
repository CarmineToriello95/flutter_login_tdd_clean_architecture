import 'package:flutter_login_tdd_clean_architecture/features/login/data/models/user_model.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tUser = UserModel(sessionId: '192837465');

  test('should be a subclass of User entity', () async {
    // assert
    expect(tUser, isA<User>());
  });
}
