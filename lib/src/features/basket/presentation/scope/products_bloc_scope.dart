import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';

class ProductsBlocScope extends StatelessWidget {
  const ProductsBlocScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        interactor: context.read<ProductsInteractor>(),
      ),
      child: child,
    );
  }
}
