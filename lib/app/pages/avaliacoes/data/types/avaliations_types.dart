import '../../../../../common/error/app_error.dart';
import '../../domain/model/avaliation.dart';

typedef AvaliationsOrError = Future<({AppError? error, List<Avaliation>? avaliations})>;
