import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class BasketRepository {
  ValueStream<Basket> get basketStream;
  Future<void> addProduct(Product product);
  Future<void> clear();
}
