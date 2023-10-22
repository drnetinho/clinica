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
        "https://firebasestorage.googleapis.com/v0/b/devwebclinica.appspot.com/o/empty_avatar.jpg?alt=media&token=79efc5d3-56e7-4407-b3fd-da6e26b8beaf&_gl=1*yp8q2i*_ga*MzUyMzMyNDgwLjE2OTEzNDE3MTY.*_ga_CW55HF8NVT*MTY5ODAxMTUyMS44My4xLjE2OTgwMTE2MzEuMzcuMC4w",
  };
}
