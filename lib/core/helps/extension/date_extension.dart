import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// return true if DateTime param is Before or is Equal DateTime.now
  bool get compareWithNow {
    final result = compareTo(DateTime.now());
    switch (result) {
      case -1:
        return true;
      case 0:
        return true;
      case 1:
        return false;
      default:
        return false;
    }
  }

  bool isTheSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String dayOfWeek() {
    switch (weekday) {
      case 1:
        return 'Segunda-Feira';
      case 2:
        return 'Terça-Feira';
      case 3:
        return 'Quarta-Feira';
      case 4:
        return 'Quinta-Feira';
      case 5:
        return 'Sexta-Feira';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  String monthPerExtens() {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
    }
  }

  String get dateAndMonth {
    return '$day ${monthPerExtens()}';
  }

  String get hourAndMinute {
    //HH:mm
    final format = DateFormat('HH:mm');
    return format.format(this);
  }

  String get hourAndMinuteLocal {
    //HH:mm
    final format = DateFormat('HH:mm');
    return format.format(toLocal());
  }

  String get formatted => DateFormat('dd/MM/yyyy').format(this);
}
