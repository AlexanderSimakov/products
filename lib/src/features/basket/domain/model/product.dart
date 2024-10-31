import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';

@immutable
class Product {
  const Product(
    this.id,
    this.name,
    this.price,
  );

  final String id;
  final String name;
  final Price price;

  Product copyWith({
    String? id,
    String? name,
    Price? price,
  }) {
    return Product(
      id ?? this.id,
      name ?? this.name,
      price ?? this.price,
    );
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price;
}
