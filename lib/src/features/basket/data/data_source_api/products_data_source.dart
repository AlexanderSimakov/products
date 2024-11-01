import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ProductsDataSource {
  ValueStream<List<Product>> get products;
  ValueStream<List<Product>> get recommendedProducts;
  Future<void> toggleFavorite(String id, {required bool isFavorite});
}
