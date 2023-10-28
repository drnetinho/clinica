import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class EditPixForm with FormzMixin {
  final StringInput name;
  final StringInput typeKey;
  final StringInput bank;
  final StringInput pixKey;
  final StringInput urlImage;

  EditPixForm({
    this.name = const StringInput.pure(),
    this.typeKey = const StringInput.pure(),
    this.bank = const StringInput.pure(),
    this.pixKey = const StringInput.pure(),
   this.urlImage = const StringInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        name,
        typeKey,
        bank,
        pixKey,
        urlImage,
      ];

  EditPixForm copyWith({
    StringInput? name,
    StringInput? typeKey,
    StringInput? bank,
    StringInput? pixKey,
    StringInput? urlImage,
  }) {
    return EditPixForm(
      name: name ?? this.name,
      typeKey: typeKey ?? this.typeKey,
      bank: bank ?? this.bank,
      pixKey: pixKey ?? this.pixKey,
      urlImage: urlImage ?? this.urlImage,
    );
  }
}
