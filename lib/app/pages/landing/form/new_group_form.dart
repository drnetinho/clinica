import 'package:formz/formz.dart';

import '../../../../../common/form/inputs.dart';

class WalletForm with FormzMixin {
  final CpfInput cpf;

  WalletForm({
    this.cpf = const CpfInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        cpf,
      ];

  WalletForm copyWith({
    CpfInput? cpf,
  }) {
    return WalletForm(
      cpf: cpf ?? this.cpf,
    );
  }
}
