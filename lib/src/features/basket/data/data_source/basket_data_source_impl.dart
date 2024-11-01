import 'package:product_basket/src/features/basket/data/data_source_api/basket_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/products/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

class BasketDataSourceImpl implements BasketDataSource {
  BasketDataSourceImpl();

  @override
  ValueStream<Basket> get basket => _basketSubject;

  final BehaviorSubject<Basket> _basketSubject =
      BehaviorSubject<Basket>.seeded(const Basket());

  @override
  Future<void> add(Product product) async {
    await _simulateDelay();

    final basket = Basket([
      ..._basketSubject.value.products,
      product,
    ]);
    _basketSubject.add(basket);
  }

  @override
  Future<void> clear() async {
    await _simulateDelay();

    _basketSubject.add(const Basket());
  }

  Future<void> _simulateDelay() =>
      Future<void>.delayed(const Duration(milliseconds: 200));
}
