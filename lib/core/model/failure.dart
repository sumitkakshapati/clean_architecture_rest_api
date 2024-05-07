abstract class Failure implements Exception {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.statusCode});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message, super.statusCode});
}
