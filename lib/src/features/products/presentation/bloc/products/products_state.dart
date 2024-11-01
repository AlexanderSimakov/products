part of 'products_bloc.dart';

@immutable
sealed class ProductsState with EquatableMixin {
  const ProductsState({
    required this.products,
    required this.recommendedProducts,
  });

  final List<Product> products;
  final List<Product> recommendedProducts;

  @override
  List<Object?> get props => [
        products,
        recommendedProducts,
      ];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial()
      : super(
          products: const [],
          recommendedProducts: const [],
        );
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading({
    required super.products,
    required super.recommendedProducts,
  });
}

final class ProductsLoaded extends ProductsState {
  const ProductsLoaded({
    required super.products,
    required super.recommendedProducts,
  });
}

final class ProductsError extends ProductsState {
  const ProductsError({
    required super.products,
    required super.recommendedProducts,
  });
}
