import 'package:clisp/app/pages/gerenciar_pacientes/domain/model/patient_model.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_payment_model.dart';

import '../../../../../common/error/app_error.dart';
import '../../domain/model/family_group_model.dart';

typedef FamilyGroupsOrError = Future<({AppError? error, List<FamilyGroupModel>? groups})>;
typedef FamilyGroupOrError = Future<({AppError? error, FamilyGroupModel? group})>;
typedef FamilyGroupMembersOrError = Future<({AppError? error, List<PatientModel>? members})>;
typedef FamilyGroupPaymentsOrError = Future<({AppError? error, List<FamilyPaymnetModel>? payments})>;
