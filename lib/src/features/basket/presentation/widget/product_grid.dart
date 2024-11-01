import 'package:flutter/material.dart';
import 'package:product_basket/src/common/extension/theme_extension.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    required this.products,
    super.key,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 180,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          key: ObjectKey(product),
          product: product,
          backgroundColor: context.colorScheme.surface,
          withShadow: true,
        );
      },
    );
  }
}
