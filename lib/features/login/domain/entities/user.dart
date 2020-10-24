import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String sessionId;

  User({@required this.sessionId});

  @override
  List<Object> get props => [sessionId];
}
