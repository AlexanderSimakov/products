import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.withShadow,
    required this.backgroundColor,
    super.key,
  });

  final Product product;
  final bool withShadow;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    // final width = (MediaQuery.sizeOf(context).width - 90) / 2;
    final width = MediaQuery.sizeOf(context).width / 2.7;

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {},
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
            boxShadow: withShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Image.network(
                      product.imageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ProductPrice(price: product.price),
                        _AddToBasketButton(
                          product: product,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: const Color(0xFFFFA451),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddToBasketButton extends StatelessWidget {
  const _AddToBasketButton({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: GestureDetector(
        onTap: () {},
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2E7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.add,
            size: 20,
            color: Color(0xFFFFA451),
          ),
        ),
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${price.currency} ',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFA451),
        ),
        children: [
          TextSpan(
            text: price.value.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
