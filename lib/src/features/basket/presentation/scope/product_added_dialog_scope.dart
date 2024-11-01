import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/common/widget/app_dialog.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';

class ProductAddedDialogScope extends StatelessWidget {
  const ProductAddedDialogScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BasketBloc, BasketState>(
      listenWhen: (previous, current) =>
          previous is! BasketProductAdded && current is BasketProductAdded,
      listener: (context, state) {
        if (state is BasketProductAdded) {
          AppDialog.show(
            context: context,
            title: '${state.product.name} Added!',
          );
        }
      },
      child: child,
    );
  }
}
