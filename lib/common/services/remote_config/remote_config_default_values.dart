class RemoteConfigValues {
  static const String appName = 'app_name';
  static const String pix = 'pix';
  static const String clisp = 'clisp';
  static const String emptyAvatar = 'empty_avatar';

  // Valores padrões das Configurações. Em caso de erro o valor default é aplicado.
  static final defaultValues = <String, dynamic>{
    appName: 'Clinica Dr Netinho',
    pix: null,
    clisp: null,
    emptyAvatar:
        "https://firebasestorage.googleapis.com/v0/b/webclinicanetinho.appspot.com/o/avatar%2F360_F_408244382_Ex6k7k8XYzTbiXLNJgIL8gssebpLLBZQ.jpg?alt=media&token=590e412e-9ebe-4de0-a458-c70f0d2d39fe",
  };
}
