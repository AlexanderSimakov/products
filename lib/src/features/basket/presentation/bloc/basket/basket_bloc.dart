import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/interactor/basket_interactor.dart';
import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc({
    required BasketInteractor interactor,
  })  : _basketInteractor = interactor,
        super(const BasketInitial()) {
    on<_BasketLoaded>(_onBasketLoaded);
    on<AddToBasket>(_onAddToBasket);
    on<ClearBasket>(_onClearBasket);
    _initListener();
  }

  final BasketInteractor _basketInteractor;

  late final StreamSubscription<Basket> _basketSubscription;

  @override
  Future<void> close() async {
    await _basketSubscription.cancel();
    return super.close();
  }

  void _initListener() {
    _basketSubscription = _basketInteractor.basketStream.listen((basket) {
      print('Basket: $basket');
      add(_BasketLoaded(basket));
    });
  }

  Future<void> _onBasketLoaded(
    _BasketLoaded event,
    Emitter<BasketState> emit,
  ) async {
    emit(
      BasketLoaded(event.basket),
    );
  }

  Future<void> _onAddToBasket(
    AddToBasket event,
    Emitter<BasketState> emit,
  ) async {
    try {
      emit(BasketProductAdded(state.basket, event.product));

      await _basketInteractor.addProduct(event.product);
    } catch (e) {
      emit(BasketError(_basketInteractor.basketStream.value));
      emit(BasketLoaded(state.basket));
    }
  }

  Future<void> _onClearBasket(
    ClearBasket event,
    Emitter<BasketState> emit,
  ) async {
    try {
      await _basketInteractor.clear();
    } catch (e) {
      emit(BasketError(_basketInteractor.basketStream.value));
      emit(BasketLoaded(state.basket));
    }
  }
}
