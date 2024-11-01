import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card/product_card.dart';
import 'package:product_basket/src/features/basket/presentation/widget/shimmer_product_list.dart';

class RecomendedBlock extends StatelessWidget {
  const RecomendedBlock({
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
        SizedBox(
          height: 180,
          child: Center(
            child: BlocSelector<ProductsBloc, ProductsState, List<Product>>(
              selector: (state) {
                return state.recommendedProducts;
              },
              builder: (context, recommendedProducts) {
                if (recommendedProducts.isEmpty) {
                  return const ShimmerProductList();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedProducts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: ProductCard(
                      product: recommendedProducts[index],
                      withShadow: true,
                      backgroundColor: Colors.white,
                      onFavoriteChanged: (isFavorite) {
                        context.read<ProductsBloc>().add(
                              ProductsToggleFavorite(
                                recommendedProducts[index].id,
                                isFavorite: isFavorite,
                              ),
                            );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
