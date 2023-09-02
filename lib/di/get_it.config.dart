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
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../app/pages/gerenciar_pacientes/data/repository/get_patients_repository.dart'
    as _i5;
import '../app/pages/gerenciar_pacientes/view/store/patients_store.dart' as _i6;
import '../app/root/router_controller.dart' as _i7;
import '../core/services/auth/auth_service.dart' as _i3;
import '../core/services/firestore/firestore_service.dart' as _i4;
import '../core/services/shared_preferences/shared_preferences_module.dart'
    as _i9;

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
    gh.factory<_i4.FirestoreService<dynamic>>(
        () => firestoreModule.firestoreService);
    gh.factory<_i5.GetPatientsRepository>(() => _i5.GetPatientsRepositoryImpl(
        service: gh<_i4.FirestoreService<dynamic>>()));
    gh.factory<_i6.ManagePatientsStore>(
        () => _i6.ManagePatientsStore(gh<_i5.GetPatientsRepository>()));
    gh.singleton<_i7.RouterController>(_i7.RouterController());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    return this;
  }
}

class _$FirestoreModule extends _i4.FirestoreModule {}

class _$SharedPreferencesModule extends _i9.SharedPreferencesModule {}
