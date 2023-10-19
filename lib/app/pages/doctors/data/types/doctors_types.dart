import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';

import '../../../../../common/error/app_error.dart';

typedef DoctorsOrError = Future<({AppError? error, List<Doctor>? doctors})>;
