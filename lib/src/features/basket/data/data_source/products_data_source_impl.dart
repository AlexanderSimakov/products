import 'package:product_basket/src/features/basket/data/data_source_api/products_data_source.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductsDataSourceImpl implements ProductsDataSource {
  ProductsDataSourceImpl() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _productsSubject.add(_products);
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      _recommendedProductsSubject.add(
        _products
            .where((product) => _recommendedProductIds.contains(product.id))
            .toList(),
      );
    });
  }

  @override
  ValueStream<List<Product>> get productsStream => _productsSubject;

  @override
  ValueStream<List<Product>> get recommendedProductsStream =>
      _recommendedProductsSubject;

  final BehaviorSubject<List<Product>> _productsSubject =
      BehaviorSubject<List<Product>>.seeded([]);

  final BehaviorSubject<List<Product>> _recommendedProductsSubject =
      BehaviorSubject<List<Product>>.seeded([]);

  @override
  Future<void> toggleFavorite(
    String id, {
    required bool isFavorite,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    _products = _products
        .map(
          (product) => product.id == id
              ? product.copyWith(isFavorite: isFavorite)
              : product,
        )
        .toList();
    _productsSubject.add(_products);
    _recommendedProductsSubject.add(
      _products
          .where((product) => _recommendedProductIds.contains(product.id))
          .toList(),
    );
  }
}

List<Product> _products = [
  const Product(
    id: '1',
    name: 'Combo',
    price: Price(100, r'$'),
    imageUrl: 'https://clipart-library.com/image_gallery2/Salad-PNG-Image.png',
    isFavorite: false,
  ),
  const Product(
    id: '2',
    name: 'Combo',
    price: Price(100, r'$'),
    imageUrl:
        'https://static.vecteezy.com/system/resources/thumbnails/018/128/193/small/delicious-spinach-salad-with-fresh-png.png',
    isFavorite: false,
  ),
  const Product(
    id: '3',
    name: 'Product 1',
    price: Price(100, r'$'),
    imageUrl:
        'https://www.pngplay.com/wp-content/uploads/15/Salads-PNG-HD-Quality.png',
    isFavorite: false,
  ),
  const Product(
    id: '3',
    name: 'Product 2',
    price: Price(100, r'$'),
    imageUrl:
        'https://www.chipotle.com/content/dam/chipotle/menu/meal-types/salad/web-mobile/order.png',
    isFavorite: false,
  ),
  const Product(
    id: '4',
    name: 'Product 3',
    price: Price(100, r'$'),
    imageUrl:
        'https://www.hungryhowies.com/sites/default/files/2022-08/HH_Website_Menu_Detail_Page_Garden_Salad_0.png',
    isFavorite: false,
  ),
];

List<String> _recommendedProductIds = ['1', '2'];
