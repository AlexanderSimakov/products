import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/shimmer_product_card.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductList extends StatelessWidget {
  const ShimmerProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: ShimmerProductCard(),
            );
          },
        ),
      ),
    );
  }
}
