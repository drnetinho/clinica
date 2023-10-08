import '../../../../../common/error/app_error.dart';
import '../../domain/model/app_details_model.dart';

typedef AppDetailsOrError = Future<({AppError? error, AppDetailsModel? appDetails})>;
