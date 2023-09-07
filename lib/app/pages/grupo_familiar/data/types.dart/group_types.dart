import 'package:netinhoappclinica/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';

import '../../../../../common/error/app_error.dart';
import '../../domain/model/family_group_model.dart';

typedef FamilyGroupsOrError = Future<({AppError? error, List<FamilyGroupModel>? groups})>;
typedef FamilyGroupMembersOrError = Future<({AppError? error, List<PatientModel>? members})>;
