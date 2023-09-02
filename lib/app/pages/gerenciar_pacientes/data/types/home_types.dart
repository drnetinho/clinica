import '../../../../../core/error/app_error.dart';
import '../../domain/model/patient_model.dart';

typedef GetCitiesOrError = Future<({AppError? error, List<PatientModel>? cities})>;
