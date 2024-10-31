import 'package:meta/meta.dart';

@immutable
class Price {
  const Price(this.value, this.currency);

  final int value;
  final String currency;

  @override
  int get hashCode => value.hashCode ^ currency.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Price &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          currency == other.currency;
}
