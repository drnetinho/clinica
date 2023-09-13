extension StringValidators on String {
  bool get hasMinimumLength => length >= 6;
  bool get isMoreThanOne => isNotEmpty && length > 0;
  String? get validate => isMoreThanOne ? null : '';
  String get lower => toLowerCase();
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsNumber => contains(RegExp(r'[0-9]'));

  bool get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  int get monthToInt {
    switch (this) {
      case 'Janeiro':
        return 1;
      case 'Fevereiro':
        return 2;
      case 'Março':
        return 3;
      case 'Abril':
        return 4;
      case 'Maio':
        return 5;
      case 'Junho':
        return 6;
      case 'Julho':
        return 7;
      case 'Agosto':
        return 8;
      case 'Setembro':
        return 9;
      case 'Outubro':
        return 10;
      case 'Novembro':
        return 11;
      case 'Dezembro':
        return 12;
      default:
        return 1;
    }
  }
}
