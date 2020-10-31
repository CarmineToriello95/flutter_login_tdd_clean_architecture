import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required String sessionId,
  }) : super(sessionId: sessionId);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final String sessionId = (json['message'] as String).split(':')[1];
    return UserModel(sessionId: sessionId);
  }

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
      };
}
