import 'package:rxdart/rxdart.dart';

abstract class StreamUtils {
  static Stream<T> debounce<T>(Stream<T> stream, Duration duration) {
    return stream.debounceTime(duration);
  }
}
