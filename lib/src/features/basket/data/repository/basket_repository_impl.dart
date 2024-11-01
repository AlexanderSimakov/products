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
  ValueStream<Basket> get basket => _dataSource.basket;

  @override
  Future<void> add(Product product) => _dataSource.add(product);

  @override
  Future<void> clear() => _dataSource.clear();
}
