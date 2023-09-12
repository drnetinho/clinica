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
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i9;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i4;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i7;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i15;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i18;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i14;
import '../app/pages/grupo_familiar/data/repository/get_groups_repository.dart'
    as _i8;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i5;
import '../app/pages/grupo_familiar/view/controller/grupo_familiar_controller.dart'
    as _i12;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i19;
import '../app/pages/grupo_familiar/view/store/group_members_store.dart'
    as _i11;
import '../app/pages/grupo_familiar/view/store/group_payments_store.dart'
    as _i10;
import '../app/pages/grupo_familiar/view/store/grupo_familiar_store.dart'
    as _i13;
import '../app/root/router_controller.dart' as _i16;
import '../common/services/auth/auth_service.dart' as _i3;
import '../common/services/firestore/firestore_service.dart' as _i6;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i20;

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
    gh.singleton<_i3.AuthService>(_i3.AuthService());
    gh.factory<_i4.FichaMedicaController>(() => _i4.FichaMedicaController());
    gh.factory<_i5.FilterController>(() => _i5.FilterController());
    gh.factory<_i6.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.singleton<_i7.GerenciarPacientesController>(
        _i7.GerenciarPacientesController());
    gh.factory<_i8.GetGroupsRepository>(() => _i8.GetGroupsRepositoryImpl());
    gh.factory<_i9.GetPatientsRepository>(
        () => _i9.GetPatientsRepositoryImpl());
    gh.factory<_i10.GroupPaymentsStore>(
        () => _i10.GroupPaymentsStore(gh<_i8.GetGroupsRepository>()));
    gh.factory<_i11.GrupMembersStore>(
        () => _i11.GrupMembersStore(gh<_i8.GetGroupsRepository>()));
    gh.factory<_i12.GrupoFamiliarController>(
        () => _i12.GrupoFamiliarController());
    gh.factory<_i13.GrupoFamiliarStore>(
        () => _i13.GrupoFamiliarStore(gh<_i8.GetGroupsRepository>()));
    gh.factory<_i14.ManagePatientsStore>(
        () => _i14.ManagePatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.singleton<_i15.NewPatientFormController>(
        _i15.NewPatientFormController());
    gh.singleton<_i16.RouterController>(_i16.RouterController());
    await gh.factoryAsync<_i17.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i18.EditPatientsStore>(
        () => _i18.EditPatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.factory<_i19.EditPaymentsStore>(
        () => _i19.EditPaymentsStore(gh<_i8.GetGroupsRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i6.FirestoreModule {}

class _$SharedPreferencesModule extends _i20.SharedPreferencesModule {}
