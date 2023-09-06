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
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i6;
import '../app/pages/gerenciar_pacientes/view/controller/ficha_medica_controller.dart'
    as _i4;
import '../app/pages/gerenciar_pacientes/view/store/edit_patient_store.dart'
    as _i10;
import '../app/pages/gerenciar_pacientes/view/store/manage_patient_store.dart'
    as _i7;
import '../app/root/router_controller.dart' as _i8;
import '../common/services/auth/auth_service.dart' as _i3;
import '../common/services/firestore/firestore_service.dart' as _i5;
import '../common/services/shared_preferences/shared_preferences_module.dart'
    as _i11;

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
    gh.singleton<_i4.FichaMedicaController>(_i4.FichaMedicaController());
    gh.factory<_i5.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i6.GetPatientsRepository>(() => _i6.GetPatientsRepositoryImpl(
        service: gh<_i5.FirestoreService<dynamic>>()));
    gh.factory<_i7.ManagePatientsStore>(
        () => _i7.ManagePatientsStore(gh<_i6.GetPatientsRepository>()));
    gh.singleton<_i8.RouterController>(_i8.RouterController());
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i10.EditPatientsStore>(
        () => _i10.EditPatientsStore(gh<_i6.GetPatientsRepository>()));
    return this;
  }
}

class _$FirestoreModule extends _i5.FirestoreModule {}

class _$SharedPreferencesModule extends _i11.SharedPreferencesModule {}
