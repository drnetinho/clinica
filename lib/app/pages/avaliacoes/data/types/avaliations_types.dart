import 'package:clisp/app/pages/doctors/domain/model/doctor.dart';

import '../../../../../common/error/app_error.dart';

typedef AvaliationsOrError = Future<({AppError? error, List<Doctor>? avaliations})>;
