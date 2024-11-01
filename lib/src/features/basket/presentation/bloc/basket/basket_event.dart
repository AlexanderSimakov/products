part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent with EquatableMixin {
  const BasketEvent();

  @override
  List<Object?> get props => [];
}

final class _BasketLoaded extends BasketEvent {
  const _BasketLoaded(this.basket);

  final Basket basket;

  @override
  List<Object?> get props => [basket];
}

final class BasketAddProduct extends BasketEvent {
  const BasketAddProduct(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

final class BasketClear extends BasketEvent {
  const BasketClear();
}
