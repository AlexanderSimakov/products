import 'package:product_basket/src/features/products/data/data_source_api/products_data_source.dart';
import 'package:product_basket/src/features/products/domain/model/product.dart';
import 'package:product_basket/src/features/products/domain/repository_api/products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({
    required ProductsDataSource dataSource,
  }) : _dataSource = dataSource;

  final ProductsDataSource _dataSource;

  @override
  ValueStream<List<Product>> get products => _dataSource.products;

  @override
  ValueStream<List<Product>> get recommendedProducts =>
      _dataSource.recommendedProducts;

  @override
  Future<void> toggleFavorite(String id, {required bool isFavorite}) =>
      _dataSource.toggleFavorite(id, isFavorite: isFavorite);
}
