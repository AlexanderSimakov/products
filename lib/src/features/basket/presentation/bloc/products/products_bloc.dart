import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsInteractor interactor,
  })  : _interactor = interactor,
        super(const ProductsInitial()) {
    on<_ProductsLoaded>(_onProductsLoaded);
    on<ProductsToggleFavorite>(
      _onToggleFavorite,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 200))
          .asyncExpand(mapper),
    );

    _initListeners();
  }

  final ProductsInteractor _interactor;

  late final StreamSubscription<List<Product>> _productsSub;
  late final StreamSubscription<List<Product>> _recommendedProductsSub;

  @override
  Future<void> close() async {
    await _productsSub.cancel();
    await _recommendedProductsSub.cancel();
    await super.close();
  }

  void _initListeners() {
    _productsSub = _interactor.products.listen(
      (products) => add(_ProductsLoaded(products: products)),
    );
    _recommendedProductsSub = _interactor.recommendedProducts.listen(
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
        products: _interactor.products.value,
        recommendedProducts: _interactor.recommendedProducts.value,
      ),
    );
  }

  Future<void> _onToggleFavorite(
    ProductsToggleFavorite event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      await _interactor.toggleFavorite(
        event.id,
        isFavorite: event.isFavorite,
      );
    } catch (e) {
      emit(
        ProductsError(
          products: _interactor.products.value,
          recommendedProducts: _interactor.recommendedProducts.value,
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
