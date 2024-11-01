import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_basket/src/features/basket/domain/interactor/basket_interactor.dart';
import 'package:product_basket/src/features/basket/domain/model/basket.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:rxdart/rxdart.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc({
    required BasketInteractor interactor,
  })  : _interactor = interactor,
        super(const BasketInitial()) {
    on<_BasketLoaded>(_onBasketLoaded);
    on<BasketAddProduct>(_onAddToBasket);
    on<BasketClear>(
      _onClearBasket,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 200))
          .asyncExpand(mapper),
    );

    _initListener();
  }

  final BasketInteractor _interactor;

  late final StreamSubscription<Basket> _basketSub;

  @override
  Future<void> close() async {
    await _basketSub.cancel();
    await super.close();
  }

  void _initListener() {
    _basketSub = _interactor.basket.listen((basket) {
      add(_BasketLoaded(basket));
    });
  }

  Future<void> _onBasketLoaded(
    _BasketLoaded event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoaded(event.basket));
  }

  Future<void> _onAddToBasket(
    BasketAddProduct event,
    Emitter<BasketState> emit,
  ) async {
    try {
      emit(BasketLoading(state.basket));
      await _interactor.add(event.product);
      emit(BasketProductAdded(state.basket, event.product));
    } catch (e) {
      emit(BasketError(_interactor.basket.value));
      emit(BasketLoaded(state.basket));
    }
  }

  Future<void> _onClearBasket(
    BasketClear event,
    Emitter<BasketState> emit,
  ) async {
    try {
      emit(BasketLoading(state.basket));
      await _interactor.clear();
    } catch (e) {
      emit(BasketError(_interactor.basket.value));
      emit(BasketLoaded(state.basket));
    }
  }
}
