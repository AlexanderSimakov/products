import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_card.dart';

class ProductByCategoryBlock extends StatelessWidget {
  const ProductByCategoryBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Categories(
          categories: [
            'Hottest',
            'Popular',
            'New combo',
            'Top',
          ],
          selectedCategoryIndex: 0,
        ),
        SizedBox(height: 16),
        _Products(
          products: [
            Product(
              id: '1',
              name: 'Product 1',
              price: Price(100, r'$'),
              imageUrl:
                  'https://www.pngplay.com/wp-content/uploads/15/Salads-PNG-HD-Quality.png',
              isFavorite: false,
            ),
            Product(
              id: '2',
              name: 'Product 2',
              price: Price(100, r'$'),
              imageUrl:
                  'https://www.chipotle.com/content/dam/chipotle/menu/meal-types/salad/web-mobile/order.png',
              isFavorite: false,
            ),
            Product(
              id: '3',
              name: 'Product 3',
              price: Price(100, r'$'),
              imageUrl:
                  'https://www.hungryhowies.com/sites/default/files/2022-08/HH_Website_Menu_Detail_Page_Garden_Salad_0.png',
              isFavorite: false,
            ),
          ],
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
          ),
        ),
      ),
    );
  }
}
