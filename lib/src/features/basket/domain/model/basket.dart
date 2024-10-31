import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';

@immutable
class Basket {
  const Basket([this.products = const []]);

  final List<Product> products;

  @override
  int get hashCode => products.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Basket &&
          runtimeType == other.runtimeType &&
          products == other.products;
}
