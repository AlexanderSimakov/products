part of 'products_search_bloc.dart';

@immutable
sealed class ProductsSearchState {
  const ProductsSearchState({
    required this.products,
    required this.filter,
    required this.query,
  });

  final List<Product> products;
  final List<Category> filter;
  final String query;

  @override
  int get hashCode => products.hashCode ^ filter.hashCode ^ query.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsSearchState &&
          runtimeType == other.runtimeType &&
          products == other.products &&
          filter == other.filter &&
          query == other.query;
}

final class ProductsSearchEmpty extends ProductsSearchState {
  const ProductsSearchEmpty({
    required super.filter,
    required super.query,
  }) : super(products: const []);
}

final class ProductsSearchLoaded extends ProductsSearchState {
  const ProductsSearchLoaded({
    required super.products,
    required super.filter,
    required super.query,
  });
}
