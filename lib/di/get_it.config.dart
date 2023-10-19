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
import 'package:shared_preferences/shared_preferences.dart' as _i26;

import '../app/pages/doctors/data/repository/doctors_repository.dart' as _i5;
import '../app/pages/doctors/view/store/doctor_store.dart' as _i6;
import '../app/pages/formas_pagamento/data/repository/get_pix_repository.dart'
    as _i15;
import '../app/pages/formas_pagamento/view/controller/edit_pix_controller.dart'
    as _i8;
import '../app/pages/formas_pagamento/view/controller/formas_pagamento_controller.dart'
    as _i12;
import '../app/pages/formas_pagamento/view/store/edit_pix_store.dart' as _i32;
import '../app/pages/formas_pagamento/view/store/get_pix_store.dart' as _i16;
import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i14;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i9;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i13;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i22;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i30;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i21;
import '../app/pages/grupo_familiar/data/repository/group_payments_repository.dart'
    as _i18;
import '../app/pages/grupo_familiar/data/repository/groups_repository.dart'
    as _i19;
import '../app/pages/grupo_familiar/view/controller/add_group_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/edit_group_controller.dart'
    as _i7;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i10;
import '../app/pages/grupo_familiar/view/controller/group_page_controller.dart'
    as _i17;
import '../app/pages/grupo_familiar/view/store/edit_groups_stores.dart' as _i28;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i31;
import '../app/pages/grupo_familiar/view/store/get_group_members_store.dart'
    as _i34;
import '../app/pages/grupo_familiar/view/store/get_group_payments_store.dart'
    as _i37;
import '../app/pages/grupo_familiar/view/store/get_groups_store.dart' as _i35;
import '../app/pages/home/data/repository/home_repository.dart' as _i20;
import '../app/pages/home/view/store/app_details_store.dart' as _i29;
import '../app/pages/landing/controller/wallet_controller.dart' as _i27;
import '../app/pages/landing/store/get_group_cpf_store.dart' as _i33;
import '../app/pages/relatorios/view/store/get_payments_store.dart' as _i36;
import '../app/pages/scale/data/repository/scale_repository.dart' as _i24;
import '../app/pages/scale/view/store/scale_store.dart' as _i25;
import '../app/root/router_controller.dart' as _i23;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i11;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i38;

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
    gh.factory<_i5.DoctorRepository>(() => _i5.DoctorRepositoryImpl());
    gh.factory<_i6.DoctorStore>(
        () => _i6.DoctorStore(gh<_i5.DoctorRepository>()));
    gh.singleton<_i7.EditGroupController>(_i7.EditGroupController());
    gh.singleton<_i8.EditPixController>(_i8.EditPixController());
    gh.factory<_i9.FichaMedicaController>(() => _i9.FichaMedicaController());
    gh.factory<_i10.FilterController>(() => _i10.FilterController());
    gh.factory<_i11.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i12.FormasPagamentoController>(
        () => _i12.FormasPagamentoController());
    gh.singleton<_i13.GerenciarPacientesController>(
        _i13.GerenciarPacientesController());
    gh.factory<_i14.GetPatientsRepository>(
        () => _i14.GetPatientsRepositoryImpl());
    gh.factory<_i15.GetPixRepository>(() => _i15.GetPixRepositoryImpl(
        service: gh<_i11.FirestoreService<dynamic>>()));
    gh.factory<_i16.GetPixStore>(
        () => _i16.GetPixStore(gh<_i15.GetPixRepository>()));
    gh.singleton<_i17.GroupPageController>(_i17.GroupPageController());
    gh.factory<_i18.GroupPaymentsRepository>(
        () => _i18.GroupPaymentsRepositoryImpl());
    gh.factory<_i19.GroupsRepository>(() => _i19.GroupsRepositoryImpl());
    gh.factory<_i20.HomeRepository>(() => _i20.HomeRepositoryImpl());
    gh.singleton<_i21.ManagePatientsStore>(
        _i21.ManagePatientsStore(gh<_i14.GetPatientsRepository>()));
    gh.singleton<_i22.NewPatientFormController>(
        _i22.NewPatientFormController());
    gh.singleton<_i23.RouterController>(_i23.RouterController());
    gh.factory<_i24.ScaleRepository>(() => _i24.ScaleRepositoryImpl());
    gh.factory<_i25.ScaleStore>(
        () => _i25.ScaleStore(gh<_i24.ScaleRepository>()));
    await gh.factoryAsync<_i26.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i27.WalletController>(() => _i27.WalletController());
    gh.factory<_i28.AddGroupStore>(
        () => _i28.AddGroupStore(gh<_i19.GroupsRepository>()));
    gh.factory<_i29.AppDetailsStore>(
        () => _i29.AppDetailsStore(gh<_i20.HomeRepository>()));
    gh.factory<_i28.DeleteGroupStore>(
        () => _i28.DeleteGroupStore(gh<_i19.GroupsRepository>()));
    gh.factory<_i28.EditGroupStore>(
        () => _i28.EditGroupStore(gh<_i19.GroupsRepository>()));
    gh.factory<_i30.EditPatientsStore>(
        () => _i30.EditPatientsStore(gh<_i14.GetPatientsRepository>()));
    gh.factory<_i31.EditPaymentsStore>(
        () => _i31.EditPaymentsStore(gh<_i18.GroupPaymentsRepository>()));
    gh.factory<_i32.EditPixStore>(
        () => _i32.EditPixStore(gh<_i15.GetPixRepository>()));
    gh.factory<_i33.GetGroupByCpfStore>(
        () => _i33.GetGroupByCpfStore(gh<_i19.GroupsRepository>()));
    gh.factory<_i34.GetGroupMembersStore>(
        () => _i34.GetGroupMembersStore(gh<_i19.GroupsRepository>()));
    gh.singleton<_i35.GetGroupsStore>(
        _i35.GetGroupsStore(gh<_i19.GroupsRepository>()));
    gh.singleton<_i36.GetRelatoriosPaymentsStore>(
        _i36.GetRelatoriosPaymentsStore(gh<_i18.GroupPaymentsRepository>()));
    gh.factory<_i37.GetGroupPaymentsStore>(() => _i37.GetGroupPaymentsStore(
          gh<_i18.GroupPaymentsRepository>(),
          gh<_i36.GetRelatoriosPaymentsStore>(),
        ));
    return this;
  }
}

class _$FirestoreModule extends _i11.FirestoreModule {}

class _$SharedPreferencesModule extends _i38.SharedPreferencesModule {}
