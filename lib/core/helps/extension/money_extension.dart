import 'package:intl/intl.dart';

extension MoneyExtension on double {
  static final NumberFormat formatter = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

  String get toReal {
    return formatter.format(this);
  }

  double get toCurrency => (this / 100).toDouble();

  NumberFormat get format => formatter;
}
