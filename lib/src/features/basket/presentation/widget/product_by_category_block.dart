import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/products_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card.dart';

class ProductByCategoryBlock extends StatelessWidget {
  const ProductByCategoryBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Categories(
          categories: [
            'Hottest',
            'Popular',
            'New combo',
            'Top',
          ],
          selectedCategoryIndex: 0,
        ),
        const SizedBox(height: 16),
        BlocSelector<ProductsBloc, ProductsState, List<Product>>(
          selector: (state) {
            return state.products;
          },
          builder: (context, products) {
            return _Products(
              products: products,
            );
          },
        ),
      ],
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({
    required this.categories,
    required this.selectedCategoryIndex,
  });

  final List<String> categories;
  final int selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Category(
                title: categories[index],
                isSelected: index == selectedCategoryIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    required this.title,
    required this.isSelected,
    super.key,
  });

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
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
