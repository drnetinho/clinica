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
import 'package:shared_preferences/shared_preferences.dart' as _i24;

import '../app/pages/avaliacoes/data/repository/doctors_repository.dart'
    as _i28;
import '../app/pages/avaliacoes/view/store/avaliations_store.dart' as _i31;
import '../app/pages/doctors/data/repository/doctors_repository.dart' as _i29;
import '../app/pages/doctors/view/store/doctor_store.dart' as _i30;
import '../app/pages/doctors/view/store/edit_doctor_store.dart' as _i32;
import '../app/pages/formas_pagamento/data/repository/get_pix_repository.dart'
    as _i13;
import '../app/pages/formas_pagamento/view/controller/edit_pix_controller.dart'
    as _i6;
import '../app/pages/formas_pagamento/view/controller/formas_pagamento_controller.dart'
    as _i10;
import '../app/pages/formas_pagamento/view/store/edit_pix_store.dart' as _i35;
import '../app/pages/formas_pagamento/view/store/get_pix_store.dart' as _i14;
import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i12;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i7;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i11;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i20;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i33;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i19;
import '../app/pages/grupo_familiar/data/repository/group_payments_repository.dart'
    as _i16;
import '../app/pages/grupo_familiar/data/repository/groups_repository.dart'
    as _i17;
import '../app/pages/grupo_familiar/view/controller/add_group_controller.dart'
    as _i3;
import '../app/pages/grupo_familiar/view/controller/edit_group_controller.dart'
    as _i5;
import '../app/pages/grupo_familiar/view/controller/filter_controller.dart'
    as _i8;
import '../app/pages/grupo_familiar/view/controller/group_page_controller.dart'
    as _i15;
import '../app/pages/grupo_familiar/view/store/edit_groups_stores.dart' as _i26;
import '../app/pages/grupo_familiar/view/store/edit_payment_store.dart' as _i34;
import '../app/pages/grupo_familiar/view/store/get_group_members_store.dart'
    as _i37;
import '../app/pages/grupo_familiar/view/store/get_group_payments_store.dart'
    as _i40;
import '../app/pages/grupo_familiar/view/store/get_groups_store.dart' as _i38;
import '../app/pages/home/data/repository/home_repository.dart' as _i18;
import '../app/pages/home/view/store/app_details_store.dart' as _i27;
import '../app/pages/landing/controller/wallet_controller.dart' as _i25;
import '../app/pages/landing/store/get_group_cpf_store.dart' as _i36;
import '../app/pages/relatorios/view/store/get_payments_store.dart' as _i39;
import '../app/pages/scale/data/repository/scale_repository.dart' as _i22;
import '../app/pages/scale/view/store/scale_store.dart' as _i23;
import '../app/root/router_controller.dart' as _i21;
import '../common/services/auth/auth_service.dart' as _i4;
import '../common/services/firestore/firestore_service.dart' as _i9;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i41;

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
    gh.singleton<_i6.EditPixController>(_i6.EditPixController());
    gh.factory<_i7.FichaMedicaController>(() => _i7.FichaMedicaController());
    gh.factory<_i8.FilterController>(() => _i8.FilterController());
    gh.factory<_i9.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i10.FormasPagamentoController>(
        () => _i10.FormasPagamentoController());
    gh.singleton<_i11.GerenciarPacientesController>(
        _i11.GerenciarPacientesController());
    gh.factory<_i12.GetPatientsRepository>(
        () => _i12.GetPatientsRepositoryImpl());
    gh.factory<_i13.GetPixRepository>(() => _i13.GetPixRepositoryImpl(
        service: gh<_i9.FirestoreService<dynamic>>()));
    gh.factory<_i14.GetPixStore>(
        () => _i14.GetPixStore(gh<_i13.GetPixRepository>()));
    gh.singleton<_i15.GroupPageController>(_i15.GroupPageController());
    gh.factory<_i16.GroupPaymentsRepository>(
        () => _i16.GroupPaymentsRepositoryImpl());
    gh.factory<_i17.GroupsRepository>(() => _i17.GroupsRepositoryImpl());
    gh.factory<_i18.HomeRepository>(() => _i18.HomeRepositoryImpl());
    gh.singleton<_i19.ManagePatientsStore>(
        _i19.ManagePatientsStore(gh<_i12.GetPatientsRepository>()));
    gh.singleton<_i20.NewPatientFormController>(
        _i20.NewPatientFormController());
    gh.singleton<_i21.RouterController>(_i21.RouterController());
    gh.factory<_i22.ScaleRepository>(() => _i22.ScaleRepositoryImpl());
    gh.factory<_i23.ScaleStore>(
        () => _i23.ScaleStore(gh<_i22.ScaleRepository>()));
    await gh.factoryAsync<_i24.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i25.WalletController>(() => _i25.WalletController());
    gh.factory<_i26.AddGroupStore>(
        () => _i26.AddGroupStore(gh<_i17.GroupsRepository>()));
    gh.factory<_i27.AppDetailsStore>(
        () => _i27.AppDetailsStore(gh<_i18.HomeRepository>()));
    gh.factory<_i28.AvaliationsRepository>(
        () => _i28.AvaliationsRepositoryImpl(gh<_i12.GetPatientsRepository>()));
    gh.factory<_i26.DeleteGroupStore>(
        () => _i26.DeleteGroupStore(gh<_i17.GroupsRepository>()));
    gh.factory<_i29.DoctorRepository>(
        () => _i29.DoctorRepositoryImpl(gh<_i22.ScaleRepository>()));
    gh.factory<_i30.DoctorStore>(
        () => _i30.DoctorStore(gh<_i29.DoctorRepository>()));
    gh.factory<_i31.EditAvaliationsStore>(
        () => _i31.EditAvaliationsStore(gh<_i28.AvaliationsRepository>()));
    gh.factory<_i32.EditDoctorStore>(
        () => _i32.EditDoctorStore(gh<_i29.DoctorRepository>()));
    gh.factory<_i26.EditGroupStore>(
        () => _i26.EditGroupStore(gh<_i17.GroupsRepository>()));
    gh.factory<_i33.EditPatientsStore>(
        () => _i33.EditPatientsStore(gh<_i12.GetPatientsRepository>()));
    gh.factory<_i34.EditPaymentsStore>(
        () => _i34.EditPaymentsStore(gh<_i16.GroupPaymentsRepository>()));
    gh.factory<_i35.EditPixStore>(
        () => _i35.EditPixStore(gh<_i13.GetPixRepository>()));
    gh.factory<_i23.EditScaleStore>(
        () => _i23.EditScaleStore(gh<_i22.ScaleRepository>()));
    gh.factory<_i31.GetAvaliationsStore>(
        () => _i31.GetAvaliationsStore(gh<_i28.AvaliationsRepository>()));
    gh.factory<_i36.GetGroupByCpfStore>(
        () => _i36.GetGroupByCpfStore(gh<_i17.GroupsRepository>()));
    gh.factory<_i37.GetGroupMembersStore>(
        () => _i37.GetGroupMembersStore(gh<_i17.GroupsRepository>()));
    gh.singleton<_i38.GetGroupsStore>(
        _i38.GetGroupsStore(gh<_i17.GroupsRepository>()));
    gh.singleton<_i39.GetRelatoriosPaymentsStore>(
        _i39.GetRelatoriosPaymentsStore(gh<_i16.GroupPaymentsRepository>()));
    gh.factory<_i40.GetGroupPaymentsStore>(() => _i40.GetGroupPaymentsStore(
          gh<_i16.GroupPaymentsRepository>(),
          gh<_i39.GetRelatoriosPaymentsStore>(),
        ));
    return this;
  }
}

class _$FirestoreModule extends _i9.FirestoreModule {}

class _$SharedPreferencesModule extends _i41.SharedPreferencesModule {}
