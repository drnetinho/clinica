import '../either/either.dart';
import '../error/app_error.dart';

typedef UnitOrError = Future<({AppError? error, Unit? unit})>;