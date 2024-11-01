import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:product_basket/src/features/basket/data/data_source_api/products_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductsDataSourceImpl implements ProductsDataSource {
  ProductsDataSourceImpl() {
    _products = _generateProducts(40);

    _simulateDelay(
      delayMs: 500,
      callback: () => _productsSubject.add([..._products]),
    );

    _simulateDelay(
      delayMs: 800,
      callback: () => _recommendedProductsSubject.add(
        [
          ..._products
              .where((product) => _recommendedProductIds.contains(product.id))
        ],
      ),
    );
  }

  @override
  ValueStream<List<Product>> get products => _productsSubject;

  @override
  ValueStream<List<Product>> get recommendedProducts =>
      _recommendedProductsSubject;

  final BehaviorSubject<List<Product>> _productsSubject =
      BehaviorSubject<List<Product>>.seeded([]);

  final BehaviorSubject<List<Product>> _recommendedProductsSubject =
      BehaviorSubject<List<Product>>.seeded([]);

  Future<void> _simulateDelay({
    required int delayMs,
    VoidCallback? callback,
  }) =>
      Future<void>.delayed(Duration(milliseconds: delayMs), callback);

  List<Product> _generateProducts(int count) {
    final images = [
      'https://www.hungryhowies.com/sites/default/files/2022-08/HH_Website_Menu_Detail_Page_Garden_Salad_0.png',
      'https://www.chipotle.com/content/dam/chipotle/menu/meal-types/salad/web-mobile/order.png',
      'https://www.pngplay.com/wp-content/uploads/15/Salads-PNG-HD-Quality.png',
      'https://static.vecteezy.com/system/resources/thumbnails/018/128/193/small/delicious-spinach-salad-with-fresh-png.png',
      'https://clipart-library.com/image_gallery2/Salad-PNG-Image.png',
    ];
    final prices = [5, 10, 20, 50, 100, 1000];
    final names = [
      'Salad',
      'Combo salad',
      'Super Combo Salad',
      'Product',
    ];
    return List.generate(count, (index) {
      return Product(
        id: index.toString(),
        name: '${names[index % names.length]} $index',
        price: Price(prices[index % prices.length], r'$'),
        imageUrl: images[index % images.length],
        isFavorite: false,
        category: Category.values[index % Category.values.length],
      );
    });
  }

  @override
  Future<void> toggleFavorite(
    String id, {
    required bool isFavorite,
  }) async {
    await _simulateDelay(delayMs: 100);

    final processedProducts = <Product>[];
    final processedRecommendedProducts = <Product>[];
    final processedRecommendedProductIds = <String>[];
    for (final oldProduct in _products) {
      final product = oldProduct.id == id
          ? oldProduct.copyWith(isFavorite: isFavorite)
          : oldProduct;

      processedProducts.add(product);
      if (_recommendedProductIds.contains(product.id)) {
        processedRecommendedProducts.add(product);
        processedRecommendedProductIds.add(product.id);
      }
    }

    _products = processedProducts;
    _recommendedProductIds = processedRecommendedProductIds;

    _productsSubject.add(processedProducts);
    _recommendedProductsSubject.add(processedRecommendedProducts);
  }
}

List<Product> _products = [];

List<String> _recommendedProductIds = ['1', '2'];
