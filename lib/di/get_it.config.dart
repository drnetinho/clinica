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
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import '../app/pages/formas_pagamento/data/repository/get_pix_repository.dart'
    as _i10;
import '../app/pages/formas_pagamento/view/controller/edit_pix_controller.dart'
    as _i4;
import '../app/pages/formas_pagamento/view/controller/formas_pagamento_controller.dart'
    as _i7;
import '../app/pages/formas_pagamento/view/store/edit_pix_store.dart' as _i17;
import '../app/pages/formas_pagamento/view/store/get_pix_store.dart' as _i11;
import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i9;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i5;
import '../app/pages/gerenciar_pacientes/view/controller/gerenciar_pacientes_controller.dart'
    as _i8;
import '../app/pages/gerenciar_pacientes/view/controller/new_patient_form_controller.dart'
    as _i13;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i16;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i12;
import '../app/root/router_controller.dart' as _i14;
import '../common/services/auth/auth_service.dart' as _i3;
import '../common/services/firestore/firestore_service.dart' as _i6;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i18;

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
    gh.singleton<_i4.EditPixController>(_i4.EditPixController());
    gh.factory<_i5.FichaMedicaController>(() => _i5.FichaMedicaController());
    gh.factory<_i6.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i7.FormasPagamentoController>(
        () => _i7.FormasPagamentoController());
    gh.singleton<_i8.GerenciarPacientesController>(
        _i8.GerenciarPacientesController());
    gh.factory<_i9.GetPatientsRepository>(() => _i9.GetPatientsRepositoryImpl(
        service: gh<_i6.FirestoreService<dynamic>>()));
    gh.factory<_i10.GetPixRepository>(() => _i10.GetPixRepositoryImpl(
        service: gh<_i6.FirestoreService<dynamic>>()));
    gh.factory<_i11.GetPixStore>(
        () => _i11.GetPixStore(gh<_i10.GetPixRepository>()));
    gh.factory<_i12.ManagePatientsStore>(
        () => _i12.ManagePatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.singleton<_i13.NewPatientFormController>(
        _i13.NewPatientFormController());
    gh.singleton<_i14.RouterController>(_i14.RouterController());
    await gh.factoryAsync<_i15.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i16.EditPatientsStore>(
        () => _i16.EditPatientsStore(gh<_i9.GetPatientsRepository>()));
    gh.factory<_i17.EditPixStore>(
        () => _i17.EditPixStore(gh<_i10.GetPixRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i6.FirestoreModule {}

class _$SharedPreferencesModule extends _i18.SharedPreferencesModule {}
