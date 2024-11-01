import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/category_list/product_category_list.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_list.dart';

class ProductByCategoryModule extends StatefulWidget {
  const ProductByCategoryModule({
    super.key,
  });

  @override
  State<ProductByCategoryModule> createState() =>
      _ProductByCategoryModuleState();
}

class _ProductByCategoryModuleState extends State<ProductByCategoryModule> {
  Category _selectedCategory = Category.hottest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductCategoryList(
          categories: Category.values,
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
            return ProductList(
              products: products
                  .where((product) => product.category == _selectedCategory)
                  .toList(),
              isColored: true,
            );
          },
        ),
      ],
    );
  }
}
