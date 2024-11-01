import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products_search/products_search_bloc.dart';

class ProductsSearchBlocScope extends StatelessWidget {
  const ProductsSearchBlocScope({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsSearchBloc(
        productsInteractor: context.read<ProductsInteractor>(),
      ),
      child: child,
    );
  }
}