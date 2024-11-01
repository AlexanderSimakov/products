import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/repository_api/basket_repository.dart';
import 'package:product_basket/src/features/products/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

class BasketInteractor {
  BasketInteractor({
    required BasketRepository repository,
  }) : _repository = repository;

  final BasketRepository _repository;

  ValueStream<Basket> get basket => _repository.basket;

  Future<void> add(Product product) => _repository.add(product);

  Future<void> clear() => _repository.clear();
}
