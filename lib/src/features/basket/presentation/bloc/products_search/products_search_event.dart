part of 'products_search_bloc.dart';

@immutable
sealed class ProductsSearchEvent {
  const ProductsSearchEvent();
}

final class ProductsSearchQueryChanged extends ProductsSearchEvent {
  const ProductsSearchQueryChanged(this.query);

  final String query;
}

final class ProductsSearchFilterChanged extends ProductsSearchEvent {
  const ProductsSearchFilterChanged(this.filter);

  final List<Category> filter;
}

final class _ProductsFetched extends ProductsSearchEvent {
  const _ProductsFetched(this.products);

  final List<Product> products;
}
