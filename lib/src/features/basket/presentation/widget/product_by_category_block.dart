import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/utils/category_extension.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card.dart';

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
        _Categories<Category>(
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
            return _Products(
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

class _Categories<T> extends StatelessWidget {
  const _Categories({
    required this.categories,
    required this.categoryToText,
    required this.selectedCategory,
    required this.onChanged,
  });

  final List<T> categories;
  final String Function(T) categoryToText;
  final T selectedCategory;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: CategoryItem(
                title: categoryToText(category),
                isSelected: selectedCategory == category,
                onTap: () => onChanged(category),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isSelected ? 24 : 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : const Color(0xFF938DB5),
            ),
          ),
          if (isSelected)
            const DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFFFA451),
              ),
              child: SizedBox(
                height: 3,
                width: 36,
              ),
            ),
        ],
      ),
    );
  }
}

class _Products extends StatelessWidget {
  const _Products({
    required this.products,
  });

  final List<Product> products;

  static final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: ProductCard(
            product: products[index],
            withShadow: false,
            backgroundColor: _colors[index % _colors.length].withOpacity(0.05),
            onFavoriteChanged: (isFavorite) {
              context.read<ProductsBloc>().add(
                    ToggleFavorite(
                      id: products[index].id,
                      isFavorite: isFavorite,
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
