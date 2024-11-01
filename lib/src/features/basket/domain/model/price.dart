import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Price with EquatableMixin {
  const Price(this.value, this.currency);

  final int value;
  final String currency;

  @override
  List<Object?> get props => [
        value,
        currency,
      ];
}
