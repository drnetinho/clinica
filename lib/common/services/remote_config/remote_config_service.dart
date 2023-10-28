import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:netinhoappclinica/common/services/remote_config/remote_config_default_values.dart';

//App Info

class RMConfig {
  final FirebaseRemoteConfig _remoteConfig;

  RMConfig._(this._remoteConfig);
  static RMConfig? _instance;
  static RMConfig get instance => _instance ??= RMConfig._(
        FirebaseRemoteConfig.instance,
      );

  // Values
  String get appName => _remoteConfig.getString(RemoteConfigValues.appName);
  String? get pixQrCode => _remoteConfig.getString(RemoteConfigValues.pix);
  String? get clispImage => _remoteConfig.getString(RemoteConfigValues.clisp);
  String get emptyAvatar => _remoteConfig.getString(RemoteConfigValues.emptyAvatar);

  // Configs
  Future<void> initialize() async {
    try {
      // await _remoteConfig.setDefaults(RemoteConfigValues.defaultValues);
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(minutes: 2),
        ),
      );
      await _remoteConfig.fetchAndActivate();
    } on PlatformException {
      throw ('RemoteConfig Error');
    } catch (e) {
      throw UnimplementedError();
    }
  }

  Future<void> refreshRemoteConfig() async {
    await _remoteConfig.fetchAndActivate();
  }
}
