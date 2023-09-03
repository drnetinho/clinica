import '../../../../../common/either/either.dart';
import '../../../../../common/error/app_error.dart';
import '../../domain/model/patient_model.dart';

typedef GetPatientsOrError = Future<({AppError? error, List<PatientModel>? patients})>;
typedef DeletePatientOrError = Future<({AppError? error, Unit? unit})>;
typedef EditPatientOrError = Future<({AppError? error, Unit? unit})>;
typedef AddPatientOrError = Future<({AppError? error, Unit? unit})>;
