import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';
import 'package:shimmer/shimmer.dart';

part 'add_to_basket_button.dart';
part 'product_price.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.withShadow,
    required this.backgroundColor,
    required this.onFavoriteChanged,
    super.key,
  });

  final Product product;
  final bool withShadow;
  final Color backgroundColor;
  final ValueChanged<bool> onFavoriteChanged;

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
                    CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                      progressIndicatorBuilder: (_, __, ___) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const SizedBox(
                              height: 60,
                              width: 60,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 26,
                      child: FittedBox(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductPrice(price: product.price),
                        AddToBasketButton(
                          product: product,
                          onTap: () {
                            context
                                .read<BasketBloc>()
                                .add(BasketAddProduct(product));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      onFavoriteChanged(!product.isFavorite);
                    },
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
