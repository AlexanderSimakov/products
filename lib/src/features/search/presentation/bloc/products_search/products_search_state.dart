part of 'products_search_bloc.dart';

@immutable
sealed class ProductsSearchState with EquatableMixin {
  const ProductsSearchState({
    required this.products,
    required this.filter,
    required this.query,
  });

  final List<Product> products;
  final List<Category> filter;
  final String query;

  @override
  List<Object?> get props => [
        products,
        filter,
        query,
      ];
}

final class ProductsSearchEmptyResult extends ProductsSearchState {
  const ProductsSearchEmptyResult({
    required super.filter,
    required super.query,
  }) : super(products: const []);
}

final class ProductsSearchProductsFound extends ProductsSearchState {
  const ProductsSearchProductsFound({
    required super.products,
    required super.filter,
    required super.query,
  });
}
