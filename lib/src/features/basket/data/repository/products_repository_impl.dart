import 'package:product_basket/src/features/basket/data/data_source_api/products_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/domain/repository_api/products_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({
    required ProductsDataSource dataSource,
  }) : _dataSource = dataSource;

  final ProductsDataSource _dataSource;

  @override
  ValueStream<List<Product>> get productsStream => _dataSource.productsStream;

  @override
  ValueStream<List<Product>> get recommendedProductsStream =>
      _dataSource.recommendedProductsStream;

  @override
  Future<void> toggleFavorite(
    String id, {
    required bool isFavorite,
  }) {
    return _dataSource.toggleFavorite(
      id,
      isFavorite: isFavorite,
    );
  }
}
