import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    required ProductsInteractor interactor,
  })  : _interactor = interactor,
        super(
          const ProductsSearchEmptyResult(
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
    on<_ProductsUpdated>(_onProductsFetched);

    _initListener();
  }

  final ProductsInteractor _interactor;
  late final StreamSubscription<List<Product>> _productsSub;

  void _initListener() {
    _productsSub = _interactor.products.listen((products) {
      add(_ProductsUpdated(products));
    });
  }

  @override
  Future<void> close() async {
    await _productsSub.cancel();
    await super.close();
  }

  Future<void> _onProductSearchQueryChanged(
    ProductsSearchQueryChanged event,
    Emitter<ProductsSearchState> emit,
  ) async {
    final products = _filterProducts(
      products: _interactor.products.value,
      filter: state.filter,
      query: event.query,
    );
    _emitFoundProducts(
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
      products: _interactor.products.value,
      filter: event.filter,
      query: state.query,
    );
    _emitFoundProducts(
      emit,
      products: products,
      filter: event.filter,
      query: state.query,
    );
  }

  Future<void> _onProductsFetched(
    _ProductsUpdated event,
    Emitter<ProductsSearchState> emit,
  ) async {
    final products = _filterProducts(
      products: event.products,
      filter: state.filter,
      query: state.query,
    );
    _emitFoundProducts(
      emit,
      products: products,
      filter: state.filter,
      query: state.query,
    );
  }

  void _emitFoundProducts(
    Emitter<ProductsSearchState> emit, {
    required List<Product> products,
    required List<Category> filter,
    required String query,
  }) {
    if (products.isEmpty) {
      emit(
        ProductsSearchEmptyResult(
          filter: filter,
          query: query,
        ),
      );
    } else {
      emit(
        ProductsSearchProductsFound(
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
    // Don't show products until user has entered a query or selected a filter
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
