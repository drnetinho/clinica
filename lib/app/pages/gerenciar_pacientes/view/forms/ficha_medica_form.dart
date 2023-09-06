import 'package:formz/formz.dart';

import 'inputs.dart';

class FichaMedicaForm with FormzMixin {
  final StringInput name;
  final StringInput age;
  final StringInput city;
  final StringInput street;
  final StringInput neighborhood;
  final StringInput number;
  final StringInput ilness;
  final PhoneInput phone;

  FichaMedicaForm({
    this.name = const StringInput.pure(),
    this.age = const StringInput.pure(),
    this.phone = const PhoneInput.pure(),
    this.city = const StringInput.pure(),
    this.ilness = const StringInput.pure(),
    this.neighborhood = const StringInput.pure(),
    this.number = const StringInput.pure(),
    this.street = const StringInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        name,
        age,
        phone,
        city,
        ilness,
        neighborhood,
        number,
        street,
      ];

  FichaMedicaForm copyWith({
    StringInput? name,
    StringInput? age,
    StringInput? city,
    StringInput? street,
    StringInput? neighborhood,
    StringInput? number,
    StringInput? ilness,
    PhoneInput? phone,
  }) {
    return FichaMedicaForm(
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      ilness: ilness ?? this.ilness,
      phone: phone ?? this.phone,
    );
  }
}
