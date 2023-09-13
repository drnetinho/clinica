import 'dart:convert';
import 'dart:developer' as dev;

class Logger {
  Logger._();

  static String redColor = '\x1B[31m';
  static String greenColor = '\x1B[32m';
  static String cyanColor = '\x1B[36m';
  static String whiteColor = '\x1B[37m';
  static const String _resetCode = '\x1B[0m';

  static void logInfo(String message, String color) {
    dev.log('$color$message$_resetCode');
  }

  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static void prettyPrint(dynamic args, String color, String document) {
    final prettyString = encoder.convert(args);
    logInfo('\n -----------------[${document.toUpperCase()}]-----------------', whiteColor);
    prettyString.split('\n').forEach((e) => logInfo(e, color));
  }
}
