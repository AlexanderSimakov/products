import 'package:product_basket/src/features/products/domain/model/product.dart';
import 'package:product_basket/src/features/products/domain/repository_api/products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsInteractor {
  ProductsInteractor({
    required ProductsRepository repository,
  }) : _repository = repository;

  final ProductsRepository _repository;

  ValueStream<List<Product>> get products => _repository.products;

  ValueStream<List<Product>> get recommendedProducts =>
      _repository.recommendedProducts;

  Future<void> toggleFavorite(String id, {required bool isFavorite}) =>
      _repository.toggleFavorite(id, isFavorite: isFavorite);
}
