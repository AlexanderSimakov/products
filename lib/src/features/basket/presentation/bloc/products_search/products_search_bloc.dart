import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

part 'products_search_event.dart';
part 'products_search_state.dart';

class ProductsSearchBloc
    extends Bloc<ProductsSearchEvent, ProductsSearchState> {
  ProductsSearchBloc({
    required ProductsInteractor productsInteractor,
  })  : _productsInteractor = productsInteractor,
        super(
          const ProductsSearchEmpty(
            filter: [],
            query: '',
          ),
        ) {
    on<ProductsSearchQueryChanged>(
      _onProductSearchQueryChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 200))
          .asyncExpand(mapper),
    );
    on<ProductsSearchFilterChanged>(
      _onProductSearchFilterChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 200))
          .asyncExpand(mapper),
    );
    on<_ProductsFetched>(_onProductsFetched);

    _productsSubscription = _productsInteractor.products.listen((products) {
      add(_ProductsFetched(products));
    });
  }

  final ProductsInteractor _productsInteractor;
  late final StreamSubscription<List<Product>> _productsSubscription;

  @override
  Future<void> close() async {
    await _productsSubscription.cancel();
    return super.close();
  }

  Future<void> _onProductSearchQueryChanged(
    ProductsSearchQueryChanged event,
    Emitter<ProductsSearchState> emit,
  ) async {
    final products = _filterProducts(
      products: _productsInteractor.products.value,
      filter: state.filter,
      query: event.query,
    );
    _emitNewProducts(
      emit,
      products: products,
      filter: state.filter,
      query: event.query,
    );
  }

  Future<void> _onProductSearchFilterChanged(
    ProductsSearchFilterChanged event,
    Emitter<ProductsSearchState> emit,
  ) async {
    final products = _filterProducts(
      products: _productsInteractor.products.value,
      filter: event.filter,
      query: state.query,
    );
    _emitNewProducts(
      emit,
      products: products,
      filter: event.filter,
      query: state.query,
    );
  }

  Future<void> _onProductsFetched(
    _ProductsFetched event,
    Emitter<ProductsSearchState> emit,
  ) async {
    final products = _filterProducts(
      products: event.products,
      filter: state.filter,
      query: state.query,
    );
    _emitNewProducts(
      emit,
      products: products,
      filter: state.filter,
      query: state.query,
    );
  }

  void _emitNewProducts(
    Emitter<ProductsSearchState> emit, {
    required List<Product> products,
    required List<Category> filter,
    required String query,
  }) {
    if (products.isEmpty) {
      emit(
        ProductsSearchEmpty(
          filter: filter,
          query: query,
        ),
      );
    } else {
      emit(
        ProductsSearchLoaded(
          products: products,
          filter: filter,
          query: query,
        ),
      );
    }
  }

  List<Product> _filterProducts({
    required List<Product> products,
    required List<Category> filter,
    required String query,
  }) {
    if (query.isEmpty && filter.isEmpty) {
      return [];
    }

    return products.where((product) {
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query.toLowerCase());
      final matchesFilter = filter.isEmpty || filter.contains(product.category);

      return matchesQuery && matchesFilter;
    }).toList();
  }
}
