sealed class AppError {}

class DomainError extends AppError {
  final String? message;

  DomainError({this.message});
}

class RemoteError extends AppError {
  final String? message;

  RemoteError({this.message});
}

extension AppErrorExtension on AppError? {
  bool get exists => this != null;
}
