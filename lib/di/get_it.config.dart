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
import 'package:shared_preferences/shared_preferences.dart' as _i27;

import '../app/pages/doctors/data/repository/doctors_repository.dart' as _i5;
import '../app/pages/doctors/view/store/doctor_store.dart' as _i6;
import '../app/pages/doctors/view/store/edit_doctor_store.dart' as _i7;
import '../app/pages/formas_pagamento/data/repository/get_pix_repository.dart'
    as _i16;
import '../app/pages/formas_pagamento/view/controller/edit_pix_controller.dart'
    as _i9;
import '../app/pages/formas_pagamento/view/controller/formas_pagamento_controller.dart'
    as _i13;
import '../app/pages/formas_pagamento/view/store/edit_pix_store.dart' as _i33;
import '../app/pages/formas_pagamento/view/store/get_pix_store.dart' as _i17;
import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i15;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i10;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i14;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i23;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i31;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i22;
import '../app/pages/grupo_familiar/data/repository/group_payments_repository.dart'
    as _i19;
import '../app/pages/grupo_familiar/data/repository/groups_repository.dart'
    as _i20;
import '../app/pages/grupo_familiar/view/controller/add_group_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/edit_group_controller.dart'
    as _i8;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i11;
import '../app/pages/grupo_familiar/view/controller/group_page_controller.dart'
    as _i18;
import '../app/pages/grupo_familiar/view/store/edit_groups_stores.dart' as _i29;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i32;
import '../app/pages/grupo_familiar/view/store/get_group_members_store.dart'
    as _i35;
import '../app/pages/grupo_familiar/view/store/get_group_payments_store.dart'
    as _i38;
import '../app/pages/grupo_familiar/view/store/get_groups_store.dart' as _i36;
import '../app/pages/home/data/repository/home_repository.dart' as _i21;
import '../app/pages/home/view/store/app_details_store.dart' as _i30;
import '../app/pages/landing/controller/wallet_controller.dart' as _i28;
import '../app/pages/landing/store/get_group_cpf_store.dart' as _i34;
import '../app/pages/relatorios/view/store/get_payments_store.dart' as _i37;
import '../app/pages/scale/data/repository/scale_repository.dart' as _i25;
import '../app/pages/scale/view/store/scale_store.dart' as _i26;
import '../app/root/router_controller.dart' as _i24;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i12;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i39;

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
    gh.factory<_i7.EditDoctorStore>(
        () => _i7.EditDoctorStore(gh<_i5.DoctorRepository>()));
    gh.singleton<_i8.EditGroupController>(_i8.EditGroupController());
    gh.singleton<_i9.EditPixController>(_i9.EditPixController());
    gh.factory<_i10.FichaMedicaController>(() => _i10.FichaMedicaController());
    gh.factory<_i11.FilterController>(() => _i11.FilterController());
    gh.factory<_i12.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i13.FormasPagamentoController>(
        () => _i13.FormasPagamentoController());
    gh.singleton<_i14.GerenciarPacientesController>(
        _i14.GerenciarPacientesController());
    gh.factory<_i15.GetPatientsRepository>(
        () => _i15.GetPatientsRepositoryImpl());
    gh.factory<_i16.GetPixRepository>(() => _i16.GetPixRepositoryImpl(
        service: gh<_i12.FirestoreService<dynamic>>()));
    gh.factory<_i17.GetPixStore>(
        () => _i17.GetPixStore(gh<_i16.GetPixRepository>()));
    gh.singleton<_i18.GroupPageController>(_i18.GroupPageController());
    gh.factory<_i19.GroupPaymentsRepository>(
        () => _i19.GroupPaymentsRepositoryImpl());
    gh.factory<_i20.GroupsRepository>(() => _i20.GroupsRepositoryImpl());
    gh.factory<_i21.HomeRepository>(() => _i21.HomeRepositoryImpl());
    gh.singleton<_i22.ManagePatientsStore>(
        _i22.ManagePatientsStore(gh<_i15.GetPatientsRepository>()));
    gh.singleton<_i23.NewPatientFormController>(
        _i23.NewPatientFormController());
    gh.singleton<_i24.RouterController>(_i24.RouterController());
    gh.factory<_i25.ScaleRepository>(() => _i25.ScaleRepositoryImpl());
    gh.factory<_i26.ScaleStore>(
        () => _i26.ScaleStore(gh<_i25.ScaleRepository>()));
    await gh.factoryAsync<_i27.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i28.WalletController>(() => _i28.WalletController());
    gh.factory<_i29.AddGroupStore>(
        () => _i29.AddGroupStore(gh<_i20.GroupsRepository>()));
    gh.factory<_i30.AppDetailsStore>(
        () => _i30.AppDetailsStore(gh<_i21.HomeRepository>()));
    gh.factory<_i29.DeleteGroupStore>(
        () => _i29.DeleteGroupStore(gh<_i20.GroupsRepository>()));
    gh.factory<_i29.EditGroupStore>(
        () => _i29.EditGroupStore(gh<_i20.GroupsRepository>()));
    gh.factory<_i31.EditPatientsStore>(
        () => _i31.EditPatientsStore(gh<_i15.GetPatientsRepository>()));
    gh.factory<_i32.EditPaymentsStore>(
        () => _i32.EditPaymentsStore(gh<_i19.GroupPaymentsRepository>()));
    gh.factory<_i33.EditPixStore>(
        () => _i33.EditPixStore(gh<_i16.GetPixRepository>()));
    gh.factory<_i34.GetGroupByCpfStore>(
        () => _i34.GetGroupByCpfStore(gh<_i20.GroupsRepository>()));
    gh.factory<_i35.GetGroupMembersStore>(
        () => _i35.GetGroupMembersStore(gh<_i20.GroupsRepository>()));
    gh.singleton<_i36.GetGroupsStore>(
        _i36.GetGroupsStore(gh<_i20.GroupsRepository>()));
    gh.singleton<_i37.GetRelatoriosPaymentsStore>(
        _i37.GetRelatoriosPaymentsStore(gh<_i19.GroupPaymentsRepository>()));
    gh.factory<_i38.GetGroupPaymentsStore>(() => _i38.GetGroupPaymentsStore(
          gh<_i19.GroupPaymentsRepository>(),
          gh<_i37.GetRelatoriosPaymentsStore>(),
        ));
    return this;
  }
}

class _$FirestoreModule extends _i12.FirestoreModule {}

class _$SharedPreferencesModule extends _i39.SharedPreferencesModule {}
