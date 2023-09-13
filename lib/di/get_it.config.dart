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
import 'package:shared_preferences/shared_preferences.dart' as _i19;

import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i10;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i5;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i8;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i17;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i20;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i16;
import '../app/pages/grupo_familiar/data/repository/get_groups_repository.dart'
    as _i9;
import '../app/pages/grupo_familiar/view/controller/add_grupo_familiar_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i6;
import '../app/pages/grupo_familiar/view/controller/grupo_familiar_controller.dart'
    as _i13;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i21;
import '../app/pages/grupo_familiar/view/store/group_members_store.dart'
    as _i11;
import '../app/pages/grupo_familiar/view/store/group_payments_store.dart'
    as _i12;
import '../app/pages/grupo_familiar/view/store/grupo_familiar_store.dart'
    as _i14;
import '../app/pages/grupo_familiar/view/store/manage_grupo_familiar_store.dart'
    as _i15;
import '../app/root/router_controller.dart' as _i18;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i7;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i22;

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
    gh.singleton<_i3.AddGrupoFamiliarController>(
        _i3.AddGrupoFamiliarController());
    gh.singleton<_i4.AuthService>(_i4.AuthService());
    gh.factory<_i5.FichaMedicaController>(() => _i5.FichaMedicaController());
    gh.factory<_i6.FilterController>(() => _i6.FilterController());
    gh.factory<_i7.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.singleton<_i8.GerenciarPacientesController>(
        _i8.GerenciarPacientesController());
    gh.factory<_i9.GetGroupsRepository>(() => _i9.GetGroupsRepositoryImpl());
    gh.factory<_i10.GetPatientsRepository>(
        () => _i10.GetPatientsRepositoryImpl());
    gh.factory<_i11.GroupMembersStore>(
        () => _i11.GroupMembersStore(gh<_i9.GetGroupsRepository>()));
    gh.factory<_i12.GroupPaymentsStore>(
        () => _i12.GroupPaymentsStore(gh<_i9.GetGroupsRepository>()));
    gh.singleton<_i13.GrupoFamiliarController>(_i13.GrupoFamiliarController());
    gh.factory<_i14.GrupoFamiliarStore>(
        () => _i14.GrupoFamiliarStore(gh<_i9.GetGroupsRepository>()));
    gh.factory<_i15.ManageGrupoFamiliarStore>(
        () => _i15.ManageGrupoFamiliarStore(gh<_i9.GetGroupsRepository>()));
    gh.factory<_i16.ManagePatientsStore>(
        () => _i16.ManagePatientsStore(gh<_i10.GetPatientsRepository>()));
    gh.singleton<_i17.NewPatientFormController>(
        _i17.NewPatientFormController());
    gh.singleton<_i18.RouterController>(_i18.RouterController());
    await gh.factoryAsync<_i19.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i20.EditPatientsStore>(
        () => _i20.EditPatientsStore(gh<_i10.GetPatientsRepository>()));
    gh.factory<_i21.EditPaymentsStore>(
        () => _i21.EditPaymentsStore(gh<_i9.GetGroupsRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i7.FirestoreModule {}

class _$SharedPreferencesModule extends _i22.SharedPreferencesModule {}
