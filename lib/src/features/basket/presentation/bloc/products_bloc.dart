import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsInteractor productsInteractor,
  })  : _productsInteractor = productsInteractor,
        super(const ProductsInitial()) {
    on<_ProductsLoaded>(_onProductsLoaded);
    on<ToggleFavorite>(_onToggleFavorite);
    _initListeners();
  }

  final ProductsInteractor _productsInteractor;

  late final StreamSubscription<List<Product>> _productsSubscription;
  late final StreamSubscription<List<Product>> _recommendedProductsSubscription;

  @override
  Future<void> close() async {
    await _productsSubscription.cancel();
    await _recommendedProductsSubscription.cancel();
    return super.close();
  }

  void _initListeners() {
    _productsSubscription = _productsInteractor.products.listen(
      (products) => add(_ProductsLoaded(products: products)),
    );
    _recommendedProductsSubscription =
        _productsInteractor.recommendedProducts.listen(
      (recommendedProducts) => add(
        _ProductsLoaded(recommendedProducts: recommendedProducts),
      ),
    );
  }

  Future<void> _onProductsLoaded(
    _ProductsLoaded event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      ProductsLoading(
        products: _productsInteractor.products.value,
        recommendedProducts: _productsInteractor.recommendedProducts.value,
      ),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      await _productsInteractor.toggleFavorite(
        event.id,
        isFavorite: event.isFavorite,
      );
    } catch (e) {
      emit(
        ProductsError(
          products: _productsInteractor.products.value,
          recommendedProducts: _productsInteractor.recommendedProducts.value,
        ),
      );
      emit(
        ProductsLoading(
          products: state.products,
          recommendedProducts: state.recommendedProducts,
        ),
      );
    }
  }
}
