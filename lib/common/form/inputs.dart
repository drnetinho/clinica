import 'package:formz/formz.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';

import 'app_form_validator.dart';

// --------------------------------------------------  ERRORS
enum StringInputError {
  empty(message: 'Digite ao menos um caractere', exists: '');

  final String message;

  /// Serve apenas para o formField ficar ativo no ErrorState
  final String exists;
  const StringInputError({required this.message, required this.exists});
}

enum MinimumStringInputError {
  minimum(message: 'Digite ao menos 6 caracteres', exists: '');

  final String message;

  /// Serve apenas para o formField ficar ativo no ErrorState
  final String exists;
  const MinimumStringInputError({required this.message, required this.exists});
}

// --------------------------------------------------  INPUTS

class StringInput extends FormzInput<String, StringInputError> {
  const StringInput.pure() : super.pure('');
  const StringInput.dirty([String value = '']) : super.dirty(value);

  @override
  StringInputError? validator(String value) {
    return value.isNotEmpty && value.isMoreThanOne ? null : StringInputError.empty;
  }
}

class MinimumStringInput extends FormzInput<String, MinimumStringInputError> {
  const MinimumStringInput.pure() : super.pure('');
  const MinimumStringInput.dirty([String value = '']) : super.dirty(value);

  @override
  MinimumStringInputError? validator(String value) {
    return value.isNotEmpty && value.hasMinimumLength ? null : MinimumStringInputError.minimum;
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