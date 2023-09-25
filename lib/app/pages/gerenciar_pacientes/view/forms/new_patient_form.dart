import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class NewPatinetForm with FormzMixin {
  final StringInput name;
  final StringInput age;
  final StringInput city;
  final StringInput street;
  final StringInput neighborhood;
  final StringInput number;
  final EmtpyInput ilness;
  final PhoneInput phone;
  final CpfInput cpf;

  NewPatinetForm({
    this.name = const StringInput.pure(),
    this.age = const StringInput.pure(),
    this.phone = const PhoneInput.pure(),
    this.city = const StringInput.pure(),
    this.ilness = const EmtpyInput.pure(),
    this.neighborhood = const StringInput.pure(),
    this.number = const StringInput.pure(),
    this.street = const StringInput.pure(),
    this.cpf = const CpfInput.pure(),
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
        cpf,
      ];

  NewPatinetForm copyWith({
    StringInput? name,
    StringInput? age,
    StringInput? city,
    StringInput? street,
    StringInput? neighborhood,
    StringInput? number,
    EmtpyInput? ilness,
    PhoneInput? phone,
    CpfInput? cpf,
  }) {
    return NewPatinetForm(
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      ilness: ilness ?? this.ilness,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
    );
  }
}
