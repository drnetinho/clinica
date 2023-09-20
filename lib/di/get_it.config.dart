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
    as _i10;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i6;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i9;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i15;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i19;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i14;
import '../app/pages/grupo_familiar/data/repository/group_payments_repository.dart'
    as _i12;
import '../app/pages/grupo_familiar/data/repository/groups_repository.dart'
    as _i13;
import '../app/pages/grupo_familiar/view/controller/add_group_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/edit_group_controller.dart'
    as _i5;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i7;
import '../app/pages/grupo_familiar/view/controller/group_page_controller.dart'
    as _i11;
import '../app/pages/grupo_familiar/view/store/edit_groups_stores.dart' as _i18;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i20;
import '../app/pages/grupo_familiar/view/store/get_group_members_store.dart'
    as _i21;
import '../app/pages/grupo_familiar/view/store/get_group_payments_store.dart'
    as _i22;
import '../app/pages/grupo_familiar/view/store/get_groups_store.dart' as _i23;
import '../app/root/router_controller.dart' as _i16;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i8;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i24;

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
    gh.singleton<_i5.EditGroupController>(_i5.EditGroupController());
    gh.factory<_i6.FichaMedicaController>(() => _i6.FichaMedicaController());
    gh.factory<_i7.FilterController>(() => _i7.FilterController());
    gh.factory<_i8.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.singleton<_i9.GerenciarPacientesController>(
        _i9.GerenciarPacientesController());
    gh.factory<_i10.GetPatientsRepository>(
        () => _i10.GetPatientsRepositoryImpl());
    gh.singleton<_i11.GroupPageController>(_i11.GroupPageController());
    gh.factory<_i12.GroupPaymentsRepository>(
        () => _i12.GroupPaymentsRepositoryImpl());
    gh.factory<_i13.GroupsRepository>(() => _i13.GroupsRepositoryImpl());
    gh.factory<_i14.ManagePatientsStore>(
        () => _i14.ManagePatientsStore(gh<_i10.GetPatientsRepository>()));
    gh.singleton<_i15.NewPatientFormController>(
        _i15.NewPatientFormController());
    gh.singleton<_i16.RouterController>(_i16.RouterController());
    await gh.factoryAsync<_i17.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i18.AddGroupStore>(
        () => _i18.AddGroupStore(gh<_i13.GroupsRepository>()));
    gh.factory<_i18.DeleteGroupStore>(
        () => _i18.DeleteGroupStore(gh<_i13.GroupsRepository>()));
    gh.factory<_i18.EditGroupStore>(
        () => _i18.EditGroupStore(gh<_i13.GroupsRepository>()));
    gh.factory<_i19.EditPatientsStore>(
        () => _i19.EditPatientsStore(gh<_i10.GetPatientsRepository>()));
    gh.factory<_i20.EditPaymentsStore>(
        () => _i20.EditPaymentsStore(gh<_i12.GroupPaymentsRepository>()));
    gh.factory<_i21.GetGroupMembersStore>(
        () => _i21.GetGroupMembersStore(gh<_i13.GroupsRepository>()));
    gh.factory<_i22.GetGroupPaymentsStore>(
        () => _i22.GetGroupPaymentsStore(gh<_i12.GroupPaymentsRepository>()));
    gh.factory<_i23.GetGroupsStore>(
        () => _i23.GetGroupsStore(gh<_i13.GroupsRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i8.FirestoreModule {}

class _$SharedPreferencesModule extends _i24.SharedPreferencesModule {}
