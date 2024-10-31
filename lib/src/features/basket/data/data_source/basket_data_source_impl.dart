import 'package:product_basket/src/features/basket/data/data_source_api/basket_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

class BasketDataSourceImpl implements BasketDataSource {
  BasketDataSourceImpl();

  @override
  ValueStream<Basket> get basketStream => _basketSubject;

  final BehaviorSubject<Basket> _basketSubject =
      BehaviorSubject<Basket>.seeded(const Basket());

  @override
  Future<void> addProduct(Product product) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final basket = Basket([
      ..._basketSubject.value.products,
      product,
    ]);
    _basketSubject.add(basket);
  }

  @override
  Future<void> clear() async {
    _basketSubject.add(const Basket());
  }
}
