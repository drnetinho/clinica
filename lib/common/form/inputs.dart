import 'package:formz/formz.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';

import 'app_form_validator.dart';

// --------------------------------------------------  ERRORS
enum StringInputError {
  empty(
    message: 'Digite ao menos um caractere',
    exists: '',
    password: 'Digite ao menos 6 caracteres',
  );

  final String message;
  final String password;

  /// Serve apenas para o formField ficar ativo no ErrorState
  final String exists;
  const StringInputError({required this.message, required this.exists, required this.password});
}

enum MinimumStringInputError {
  minimum(message: 'Digite ao menos 6 caracteres', exists: '');

  final String message;

  /// Serve apenas para o formField ficar ativo no ErrorState
  final String exists;
  const MinimumStringInputError({required this.message, required this.exists});
}

// --------------------------------------------------  INPUTS

class EmtpyInput extends FormzInput<String, StringInputError> {
  const EmtpyInput.pure() : super.pure('');
  const EmtpyInput.dirty([String value = '']) : super.dirty(value);

  @override
  StringInputError? validator(String value) {
    return null;
  }
}

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

// Email INPUT
enum EmailInputError {
  invalid(message: 'Email inválido', exists: '');

  final String message;
  final String exists;
  const EmailInputError({required this.message, required this.exists});
}

// CPF INPUT

enum CpfInputError {
  empty(message: 'Campo obrigatório', exists: '');

  final String exists;
  final String message;
  const CpfInputError({required this.message, required this.exists});
}

class CpfInput extends FormzInput<String, CpfInputError> {
  const CpfInput.pure() : super.pure('');
  const CpfInput.dirty([String value = '']) : super.dirty(value);

  @override
  CpfInputError? validator(String value) {
    final String valueWithoutMask = value.replaceAll(RegExp(r'\D'), '');
    return valueWithoutMask.isNotEmpty && (valueWithoutMask.length == 11) ? null : CpfInputError.empty;
  }
}
