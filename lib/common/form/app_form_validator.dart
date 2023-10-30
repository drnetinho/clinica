import 'package:intl/intl.dart';
import 'package:clisp/core/helps/extension/date_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';

import '../../core/helps/actual_date.dart';

class FormValidator {
  static const String requiredText = 'Este campo é obrigatório';

  static String? validateCpf(String? cpf) {
    const List<String> blacklist = <String>[
      '00000000000',
      '11111111111',
      '22222222222',
      '33333333333',
      '44444444444',
      '55555555555',
      '66666666666',
      '77777777777',
      '88888888888',
      '99999999999',
      '12345678909'
    ];

    const String stripRegex = r'[^\d]';

    // Compute the Verifier Digit (or "Dígito Verificador (DV)" in PT-BR).
    // You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
    int verifierDigit(String cpf) {
      final List<int> numbers = cpf.split('').map((String number) => int.parse(number, radix: 10)).toList();

      final int modulus = numbers.length + 1;

      final List<int> multiplied = <int>[];

      for (int i = 0; i < numbers.length; i++) {
        multiplied.add(numbers[i] * (modulus - i));
      }

      final int mod = multiplied.reduce((int buffer, int number) => buffer + number) % 11;

      return mod < 2 ? 0 : 11 - mod;
    }

    String strip(String? cpf) {
      final RegExp regExp = RegExp(stripRegex);
      cpf = cpf ?? '';

      return cpf.replaceAll(regExp, '');
    }

    bool isValid(String? cpf, bool stripBeforeValidation) {
      if (stripBeforeValidation) {
        cpf = strip(cpf);
      }

      // CPF must be defined
      if (cpf == null || cpf.isEmpty) {
        return false;
      }

      // CPF must have 11 chars
      if (cpf.length != 11) {
        return false;
      }

      // CPF can't be blacklisted
      if (blacklist.contains(cpf)) {
        return false;
      }

      String numbers = cpf.substring(0, 9);
      numbers += verifierDigit(numbers).toString();
      numbers += verifierDigit(numbers).toString();

      return numbers.substring(numbers.length - 2) == cpf.substring(cpf.length - 2);
    }

    return isValid(cpf, true) ? null : 'CPF Inválido';
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return requiredText;
    } else {
      return null;
    }
  }

  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return requiredText;
    }
    return null;
  }

  static String? validateMinimum6Characters(String? value) {
    if (value == null || value.isEmpty) {
      return requiredText;
    }

    if (value.length < 6) {
      return 'Mínimo 6 caracteres';
    }

    return null;
  }

  static String? validateBirthDateLength(String? value) {
    final String formattedValue = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (formattedValue.isEmpty) {
      return requiredText;
    }

    if (formattedValue.length < 8) {
      return 'Informe a data no formato dd/mm/aaaa.';
    }
    // Validate date
    final int day = int.parse(formattedValue.substring(0, 2));
    final int month = int.parse(formattedValue.substring(2, 4));
    final int year = int.parse(formattedValue.substring(4, 8));

    final dateNow = KCurrentDate;
    final dateFormat = DateFormat('dd/MM/yyyy');

    if (day < 1 || day > 31) {
      return 'Dia inválido';
    }

    if (month < 1 || month > 12) {
      return 'Mês inválido';
    }

    if (year < 1900 || year > dateNow.year) {
      return 'Ano inválido';
    }

    if (value != null && !dateFormat.parse(value).compareWithNow) {
      return 'Data inválida';
    }

    return null;
  }

  static bool validatePhone(String? value) {
    final RegExp regExp = RegExp(r'^\([1-9]{2}\) [2-9] [0-9]{3,4}-[0-9]{4}$');
    return regExp.hasMatch(value!);
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    if (value.containsLowercase && value.containsUppercase && value.containsNumber && value.hasMinimumLength) {
      return null;
    }

    return 'Sua senha deve obedecer aos requisitos listados';
  }

  static String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    if (value.containsLowercase && value.containsUppercase && value.containsNumber && value.hasMinimumLength) {
    } else {
      return 'Sua senha deve obedecer aos requisitos listados';
    }

    return null;
  }
}
