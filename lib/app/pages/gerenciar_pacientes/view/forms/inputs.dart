import 'package:formz/formz.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';

import '../../../../../common/form/app_form_validator.dart';

// ANY STRING INPUT
enum StringInputError {
  empty(message: 'Digite ao menos um caractere', exists: '');

  final String message;
  final String exists;
  const StringInputError({required this.message, required this.exists});
}

class StringInput extends FormzInput<String, StringInputError> {
  const StringInput.pure() : super.pure('');
  const StringInput.dirty([String value = '']) : super.dirty(value);

  @override
  StringInputError? validator(String value) {
    return value.isNotEmpty && value.isMoreThanOne ? null : StringInputError.empty;
  }
}

// PHONE INPUT
enum PhoneInputError {
  invalid(message: 'Telefone inválido', exists: '');

  final String message;
  final String exists;
  const PhoneInputError({required this.message, required this.exists});
}

class PhoneInput extends FormzInput<String, PhoneInputError> {
  const PhoneInput.pure() : super.pure('');
  const PhoneInput.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneInputError? validator(String value) {
    return FormValidator.validatePhone(value) ? null : PhoneInputError.invalid;
  }
}
