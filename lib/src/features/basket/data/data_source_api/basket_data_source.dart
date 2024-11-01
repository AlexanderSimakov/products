import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class BasketDataSource {
  ValueStream<Basket> get basket;
  Future<void> add(Product product);
  Future<void> clear();
}
