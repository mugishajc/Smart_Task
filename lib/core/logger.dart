import 'package:logger/logger.dart';

class Log {
  static final Log _singleton = Log._internal();

  factory Log() {
    return _singleton;
  }

  Log._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    );
  }

  late Logger _logger;

  static void verbose(String message, {String? tag}) =>
      _singleton._logger.v(message, tag);

  static void debug(String message, {String? tag}) =>
      _singleton._logger.d(message, tag);

  static void info(String message, {String? tag}) =>
      _singleton._logger.i(message, tag);

  static void warning(String message, {String? tag}) =>
      _singleton._logger.w(message, tag);


  static void error(dynamic message, {dynamic error, StackTrace? stackTrace, String? tag}) {
    if (tag != null) {
      _singleton._logger.e("$message (Tag: $tag)", error, stackTrace);
    } else {
      _singleton._logger.e(message, error, stackTrace);
    }
  }

}