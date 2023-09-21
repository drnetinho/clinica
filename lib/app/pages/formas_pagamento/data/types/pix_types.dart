import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../domain/model/pix_model.dart';


typedef GetPixOrError = Future<({AppError? error, PixModel? pix})>;
typedef EditPixOrError = Future<({AppError? error, Unit? unit})>;





  