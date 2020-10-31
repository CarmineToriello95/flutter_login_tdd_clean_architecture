abstract class Failure {
  Failure([List properties = const <dynamic>[]]);
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
