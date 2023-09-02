import '../../../../../core/error/app_error.dart';
import '../../domain/model/patient_model.dart';

typedef GetPatientsOrError = Future<({AppError? error, List<PatientModel>? patients})>;
