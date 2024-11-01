import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/interactor/basket_interactor.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';

class BasketBlocScope extends StatelessWidget {
  const BasketBlocScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasketBloc(
        interactor: context.read<BasketInteractor>(),
      ),
      child: child,
    );
  }
}
