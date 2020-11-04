part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class Initial extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {
  final User user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends LoginState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
