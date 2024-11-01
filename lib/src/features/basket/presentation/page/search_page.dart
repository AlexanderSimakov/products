import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/common/widget/app_bar/app_bar_basket_button.dart';
import 'package:product_basket/src/common/widget/app_bar/custom_app_bar.dart';
import 'package:product_basket/src/common/widget/app_scaffold.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products_search/products_search_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_grid.dart';
import 'package:product_basket/src/features/basket/presentation/widget/search/hero_search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CustomAppBar(
        actions: [AppBarBasketButton()],
      ),
      body: Column(
        children: [
          const SizedBox(height: 18),
          BlocSelector<ProductsSearchBloc, ProductsSearchState, List<Category>>(
            selector: (state) => state.filter,
            builder: (context, filter) {
              return HeroSearchBar(
                initialFilter: filter,
                onQueryChanged: (query) {
                  context.read<ProductsSearchBloc>().add(
                        ProductsSearchQueryChanged(query),
                      );
                },
                onFilterChanged: (filter) {
                  context.read<ProductsSearchBloc>().add(
                        ProductsSearchFilterChanged(filter),
                      );
                },
              );
            },
          ),
          const SizedBox(height: 18),
          Expanded(
            child: BlocBuilder<ProductsSearchBloc, ProductsSearchState>(
              builder: (context, state) {
                if (state.products.isEmpty) {
                  return Center(
                    child: state.query.isNotEmpty || state.filter.isNotEmpty
                        ? const Text('No products found')
                        : const Text('Search for products'),
                  );
                }

                return ProductGrid(products: state.products);
              },
            ),
          ),
        ],
      ),
    );
  }
}
