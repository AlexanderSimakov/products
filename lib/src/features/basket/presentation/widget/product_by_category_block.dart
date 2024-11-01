import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/utils/category_extension.dart';
import 'package:product_basket/src/features/basket/presentation/widget/category_list/product_category_list.dart';
import 'package:product_basket/src/features/basket/presentation/widget/colored_product_list.dart';

class ProductByCategoryBlock extends StatefulWidget {
  const ProductByCategoryBlock({
    super.key,
  });

  @override
  State<ProductByCategoryBlock> createState() => _ProductByCategoryBlockState();
}

class _ProductByCategoryBlockState extends State<ProductByCategoryBlock> {
  Category _selectedCategory = Category.hottest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductCategoryList<Category>(
          categories: const [
            Category.hottest,
            Category.popular,
            Category.newCombo,
            Category.top,
          ],
          categoryToText: (category) => category.toText(),
          selectedCategory: _selectedCategory,
          onChanged: (category) => setState(() {
            _selectedCategory = category;
          }),
        ),
        const SizedBox(height: 16),
        BlocSelector<ProductsBloc, ProductsState, List<Product>>(
          selector: (state) {
            return state.products;
          },
          builder: (context, products) {
            return ColoredProductList(
              products: products
                  .where((product) => product.category == _selectedCategory)
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
