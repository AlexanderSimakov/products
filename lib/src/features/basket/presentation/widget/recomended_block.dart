import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card.dart';

class RecomendedBlock extends StatelessWidget {
  const RecomendedBlock({
    required this.products,
    super.key,
  });

  final List<Product> products;

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
            child: RecomendedTitle(),
          ),
        ),
        SizedBox(
          height: 180,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ProductCard(
                  product: products[index],
                  withShadow: true,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RecomendedTitle extends StatelessWidget {
  const RecomendedTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Recommended Combo',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
