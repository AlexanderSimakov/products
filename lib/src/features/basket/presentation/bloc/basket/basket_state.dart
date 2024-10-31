part of 'basket_bloc.dart';

@immutable
sealed class BasketState {
  const BasketState(this.basket);

  final Basket basket;

  @override
  int get hashCode => basket.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketState &&
          runtimeType == other.runtimeType &&
          basket == other.basket;
}

final class BasketInitial extends BasketState {
  const BasketInitial() : super(const Basket());
}

final class BasketLoading extends BasketState {
  const BasketLoading(super.basket);
}

final class BasketLoaded extends BasketState {
  const BasketLoaded(super.basket);
}

final class BasketProductAdded extends BasketState {
  const BasketProductAdded(super.basket, this.product);

  final Product product;
}

final class BasketError extends BasketState {
  const BasketError(super.basket);
}
