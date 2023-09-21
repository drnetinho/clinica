import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class EditPixForm with FormzMixin {
  final StringInput name;
  final StringInput typeKey;
  final StringInput bank;
  final StringInput pixKey;

  EditPixForm({
    this.name = const StringInput.pure(),
    this.typeKey = const StringInput.pure(),
    this.bank = const StringInput.pure(),
    this.pixKey = const StringInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        name,
        typeKey,
        bank,
        pixKey,
      ];

  EditPixForm copyWith({
    StringInput? name,
    StringInput? typeKey,
    StringInput? bank,
    StringInput? pixKey,
  }) {
    return EditPixForm(
      name: name ?? this.name,
      typeKey: typeKey ?? this.typeKey,
      bank: bank ?? this.bank,
      pixKey: pixKey ?? this.pixKey,
    );
  }
}
