part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {
  const ProductsEvent();
}

final class _ProductsLoaded extends ProductsEvent {
  const _ProductsLoaded({
    this.products,
    this.recommendedProducts,
  });

  final List<Product>? products;
  final List<Product>? recommendedProducts;
}

final class ToggleFavorite extends ProductsEvent {
  const ToggleFavorite({
    required this.id,
    required this.isFavorite,
  });

  final String id;
  final bool isFavorite;
}
