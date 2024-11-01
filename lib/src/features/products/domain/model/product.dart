import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/products/domain/model/category.dart';
import 'package:product_basket/src/features/products/domain/model/price.dart';

@immutable
class Product with EquatableMixin {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    required this.category,
  });

  final String id;
  final String name;
  final Price price;
  final String imageUrl;
  final bool isFavorite;
  final Category category;

  Product copyWith({
    String? id,
    String? name,
    Price? price,
    String? imageUrl,
    bool? isFavorite,
    Category? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        imageUrl,
        isFavorite,
        category,
      ];
}
