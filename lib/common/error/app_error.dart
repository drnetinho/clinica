sealed class AppError {
  final String? message;

  AppError({this.message});
}

class DomainError implements AppError {
  @override
  final String? message;

  DomainError({this.message});
}

class RemoteError implements AppError {
  @override
  final String? message;

  RemoteError({this.message});
}

class UndefiniedError implements AppError {
  @override
  final String? message;

  UndefiniedError({this.message = 'Undefinied'});
}

extension AppErrorExtension on AppError? {
  bool get exists => this != null;
}
