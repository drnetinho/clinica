class RemoteConfigValues {
  static const String appName = 'app_name';
  static const String pix = 'pix';
  static const String clisp = 'clisp';

  // Valores padrões das Configurações. Em caso de erro o valor default é aplicado.
  static final defaultValues = <String, dynamic>{
    appName: 'Clinica Dr Netinho',
    pix: null,
    clisp: null,
  };
}
