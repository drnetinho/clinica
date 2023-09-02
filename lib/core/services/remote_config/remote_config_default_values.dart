class RemoteConfigValues {
  static const String appName = 'app_name';
  static const String blogToogle = 'blog_toogle';

  // Valores padrões das Configurações. Em caso de erro o valor default é aplicado.
  static final defaultValues = <String, dynamic>{
    appName: 'Não identificado',
    blogToogle: true,
  };
}
