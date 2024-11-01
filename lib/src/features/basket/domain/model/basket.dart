import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';

@immutable
class Basket with EquatableMixin {
  const Basket([this.products = const []]);

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}
