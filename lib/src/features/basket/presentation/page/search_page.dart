import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products_search/products_search_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/page/basket_page.dart';
import 'package:product_basket/src/features/basket/presentation/widget/basket_button.dart';
import 'package:product_basket/src/features/basket/presentation/widget/custom_app_bar.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        actions: [
          BasketButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Column(
          children: [
            const SizedBox(height: 18),
            BlocSelector<ProductsSearchBloc, ProductsSearchState,
                List<Category>>(
              selector: (state) => state.filter,
              builder: (context, filter) {
                return Hero(
                  tag: 'search_bar',
                  child: AppSearchBar(
                    initialFilter: filter,
                    onSearchQueryChanged: (query) {
                      context.read<ProductsSearchBloc>().add(
                            ProductsSearchQueryChanged(query),
                          );
                    },
                    onSearchFilterChanged: (filter) {
                      context.read<ProductsSearchBloc>().add(
                            ProductsSearchFilterChanged(filter),
                          );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Expanded(
              child: BlocBuilder<ProductsSearchBloc, ProductsSearchState>(
                builder: (context, state) {
                  if ((state.query.isNotEmpty || state.filter.isNotEmpty) &&
                      state.products.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  } else if (state.products.isEmpty) {
                    return const Center(
                      child: Text('Search for products'),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 180,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(
                        product: product,
                        backgroundColor: Colors.white,
                        onFavoriteChanged: (value) {
                          context.read<ProductsBloc>().add(
                                ToggleFavorite(
                                  id: product.id,
                                  isFavorite: value,
                                ),
                              );
                        },
                        withShadow: true,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
