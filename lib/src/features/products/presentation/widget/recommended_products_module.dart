import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/products/domain/model/product.dart';
import 'package:product_basket/src/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/products/presentation/widget/product_list.dart';

class RecomendedProductsModule extends StatelessWidget {
  const RecomendedProductsModule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recommended Combo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        BlocSelector<ProductsBloc, ProductsState, List<Product>>(
          selector: (state) => state.recommendedProducts,
          builder: (context, recommendedProducts) {
            return ProductList(
              products: recommendedProducts,
              isColored: false,
            );
          },
        ),
      ],
    );
  }
}
