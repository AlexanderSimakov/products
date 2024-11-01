part of 'products_search_bloc.dart';

@immutable
sealed class ProductsSearchEvent with EquatableMixin {
  const ProductsSearchEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsSearchQueryChanged extends ProductsSearchEvent {
  const ProductsSearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ProductsSearchFilterChanged extends ProductsSearchEvent {
  const ProductsSearchFilterChanged(this.filter);

  final List<Category> filter;

  @override
  List<Object?> get props => [filter];
}

final class _ProductsUpdated extends ProductsSearchEvent {
  const _ProductsUpdated(this.products);

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}
