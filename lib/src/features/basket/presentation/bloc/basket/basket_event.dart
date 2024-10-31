part of 'basket_bloc.dart';

@immutable
sealed class BasketEvent {
  const BasketEvent();
}

final class _BasketLoaded extends BasketEvent {
  const _BasketLoaded(this.basket);

  final Basket basket;
}

final class AddToBasket extends BasketEvent {
  const AddToBasket(this.product);

  final Product product;
}

final class ClearBasket extends BasketEvent {
  const ClearBasket();
}
