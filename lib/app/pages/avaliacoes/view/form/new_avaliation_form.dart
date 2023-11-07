import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class NewAvaliationForm with FormzMixin {
  final EmtpyInput pressaoArterial;
  final EmtpyInput frequenciaCardiaca;
  final EmtpyInput frequenciaRespiratoria;
  final EmtpyInput peso;
  final EmtpyInput altura;
  final EmtpyInput obs;

  NewAvaliationForm({
    this.pressaoArterial = const EmtpyInput.pure(),
    this.frequenciaCardiaca = const EmtpyInput.pure(),
    this.frequenciaRespiratoria = const EmtpyInput.pure(),
    this.peso = const EmtpyInput.pure(),
    this.altura = const EmtpyInput.pure(),
    this.obs = const EmtpyInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        pressaoArterial,
        frequenciaCardiaca,
        frequenciaRespiratoria,
        peso,
        altura,
        obs,
      ];

  NewAvaliationForm copyWith({
    EmtpyInput? pressaoArterial,
    EmtpyInput? frequenciaCardiaca,
    EmtpyInput? frequenciaRespiratoria,
    EmtpyInput? peso,
    EmtpyInput? altura,
    EmtpyInput? obs,
  }) {
    return NewAvaliationForm(
      pressaoArterial: pressaoArterial ?? this.pressaoArterial,
      frequenciaCardiaca: frequenciaCardiaca ?? this.frequenciaCardiaca,
      frequenciaRespiratoria: frequenciaRespiratoria ?? this.frequenciaRespiratoria,
      peso: peso ?? this.peso,
      altura: altura ?? this.altura,
      obs: obs ?? this.obs,
    );
  }
}
