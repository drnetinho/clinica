// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i9;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i5;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i8;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i14;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i18;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i13;
import '../app/pages/grupo_familiar/data/repository/group_payments_repository.dart'
    as _i11;
import '../app/pages/grupo_familiar/data/repository/groups_repository.dart'
    as _i12;
import '../app/pages/grupo_familiar/view/controller/add_group_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i6;
import '../app/pages/grupo_familiar/view/controller/group_page_controller.dart'
    as _i10;
import '../app/pages/grupo_familiar/view/store/edit_groups_stores.dart' as _i17;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i19;
import '../app/pages/grupo_familiar/view/store/get_group_members_store.dart'
    as _i20;
import '../app/pages/grupo_familiar/view/store/get_group_payments_store.dart'
    as _i21;
import '../app/pages/grupo_familiar/view/store/get_groups_store.dart' as _i22;
import '../app/root/router_controller.dart' as _i15;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i7;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i23;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firestoreModule = _$FirestoreModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    gh.singleton<_i3.AddGroupController>(_i3.AddGroupController());
    gh.singleton<_i4.AuthService>(_i4.AuthService());
    gh.factory<_i5.FichaMedicaController>(() => _i5.FichaMedicaController());
    gh.factory<_i6.FilterController>(() => _i6.FilterController());
    gh.factory<_i7.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.singleton<_i8.GerenciarPacientesController>(
        _i8.GerenciarPacientesController());
    gh.factory<_i9.GetPatientsRepository>(
        () => _i9.GetPatientsRepositoryImpl());
    gh.singleton<_i10.GroupPageController>(_i10.GroupPageController());
    gh.factory<_i11.GroupPaymentsRepository>(
        () => _i11.GroupPaymentsRepositoryImpl());
    gh.factory<_i12.GroupsRepository>(() => _i12.GroupsRepositoryImpl());
    gh.factory<_i13.ManagePatientsStore>(
        () => _i13.ManagePatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.singleton<_i14.NewPatientFormController>(
        _i14.NewPatientFormController());
    gh.singleton<_i15.RouterController>(_i15.RouterController());
    await gh.factoryAsync<_i16.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i17.AddGroupStore>(
        () => _i17.AddGroupStore(gh<_i12.GroupsRepository>()));
    gh.factory<_i17.DeleteGroupStore>(
        () => _i17.DeleteGroupStore(gh<_i12.GroupsRepository>()));
    gh.factory<_i18.EditPatientsStore>(
        () => _i18.EditPatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.factory<_i19.EditPaymentsStore>(
        () => _i19.EditPaymentsStore(gh<_i11.GroupPaymentsRepository>()));
    gh.factory<_i20.GetGroupMembersStore>(
        () => _i20.GetGroupMembersStore(gh<_i12.GroupsRepository>()));
    gh.factory<_i21.GetGroupPaymentsStore>(
        () => _i21.GetGroupPaymentsStore(gh<_i11.GroupPaymentsRepository>()));
    gh.factory<_i22.GetGroupsStore>(
        () => _i22.GetGroupsStore(gh<_i12.GroupsRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i7.FirestoreModule {}

class _$SharedPreferencesModule extends _i23.SharedPreferencesModule {}
