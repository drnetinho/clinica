import '../../../../../common/error/app_error.dart';
import '../../domain/model/doctor_scale.dart';

typedef DoctorScalesOrError = Future<({AppError? error, List<DoctorScale>? scales})>;
