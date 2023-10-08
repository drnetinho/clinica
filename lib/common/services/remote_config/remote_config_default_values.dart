class RemoteConfigValues {
  static const String appName = 'app_name';
  static const String pix = 'pix';

  // Valores padrões das Configurações. Em caso de erro o valor default é aplicado.
  static final defaultValues = <String, dynamic>{
    appName: 'Clinica Dr Netinho',
    pix: null,
  };
}
