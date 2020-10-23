import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required String sessionId,
  }) : super(sessionId: sessionId);
}
