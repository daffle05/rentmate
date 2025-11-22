abstract class Failure {
  final String message;

  Failure(this.message);

  // Manual equality
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
