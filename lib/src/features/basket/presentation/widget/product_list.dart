import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/common/extension/theme_extension.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/product_card.dart';
import 'package:product_basket/src/features/basket/presentation/widget/shimmer_product_list.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    required this.products,
    required this.isColored,
    super.key,
  });

  final List<Product> products;
  final bool isColored;

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
          final product = products[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: ProductCard(
              key: ObjectKey(product),
              product: product,
              withShadow: !isColored,
              backgroundColor: isColored
                  ? _colors[index % _colors.length].withOpacity(0.05)
                  : context.colorScheme.surface,
              onIsFavoriteChanged: (isFavorite) {
                context.read<ProductsBloc>().add(
                      ProductsToggleFavorite(
                        product.id,
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
