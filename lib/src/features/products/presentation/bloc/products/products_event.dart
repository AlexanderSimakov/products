part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent with EquatableMixin {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class _ProductsLoaded extends ProductsEvent {
  const _ProductsLoaded({
    this.products,
    this.recommendedProducts,
  });

  final List<Product>? products;
  final List<Product>? recommendedProducts;

  @override
  List<Object?> get props => [
        products,
        recommendedProducts,
      ];
}

final class ProductsToggleFavorite extends ProductsEvent {
  const ProductsToggleFavorite(
    this.id, {
    required this.isFavorite,
  });

  final String id;
  final bool isFavorite;

  @override
  List<Object?> get props => [
        id,
        isFavorite,
      ];
}
