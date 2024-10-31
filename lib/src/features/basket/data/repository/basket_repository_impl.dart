import 'package:product_basket/src/features/basket/data/data_source_api/basket_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/domain/repository_api/basket_repository.dart';
import 'package:rxdart/rxdart.dart';

class BasketRepositoryImpl implements BasketRepository {
  BasketRepositoryImpl({
    required BasketDataSource dataSource,
  }) : _dataSource = dataSource;

  final BasketDataSource _dataSource;

  @override
  ValueStream<Basket> get basketStream => _dataSource.basketStream;

  @override
  Future<void> addProduct(Product product) => _dataSource.addProduct(product);

  @override
  Future<void> clear() => _dataSource.clear();
}
