import 'package:netinhoappclinica/app/pages/home/domain/model/patient_model.dart';

import '../../../../../core/error/app_error.dart';

typedef GetCitiesOrError
    = Future<({AppError? error, List<PatientModel>? cities})>;
