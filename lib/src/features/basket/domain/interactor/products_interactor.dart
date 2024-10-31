import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/domain/repository_api/products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsInteractor {
  ProductsInteractor({
    required ProductsRepository repository,
  }) : _repository = repository;

  final ProductsRepository _repository;

  ValueStream<List<Product>> get products => _repository.productsStream;

  ValueStream<List<Product>> get recommendedProducts =>
      _repository.recommendedProductsStream;

  Future<void> toggleFavorite(
    String id, {
    required bool isFavorite,
  }) {
    return _repository.toggleFavorite(
      id,
      isFavorite: isFavorite,
    );
  }
}
