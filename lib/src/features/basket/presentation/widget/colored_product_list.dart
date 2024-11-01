import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/product_card.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/shimmer_product_card.dart';
import 'package:product_basket/src/features/basket/presentation/widget/shimmer_product_list.dart';
import 'package:shimmer/shimmer.dart';

class ColoredProductList extends StatelessWidget {
  const ColoredProductList({
    required this.products,
    super.key,
  });

  final List<Product> products;

  static final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const ShimmerProductList();
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: ProductCard(
              product: products[index],
              withShadow: false,
              backgroundColor:
                  _colors[index % _colors.length].withOpacity(0.05),
              onFavoriteChanged: (isFavorite) {
                context.read<ProductsBloc>().add(
                      ProductsToggleFavorite(
                        products[index].id,
                        isFavorite: isFavorite,
                      ),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
