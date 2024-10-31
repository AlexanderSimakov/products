import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  final String id;
  final String name;
  final Price price;
  final String imageUrl;
  final bool isFavorite;

  Product copyWith({
    String? id,
    String? name,
    Price? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      isFavorite.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          imageUrl == other.imageUrl &&
          isFavorite == other.isFavorite;
}
