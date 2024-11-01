import 'package:flutter/material.dart';

part 'product_category_list_item.dart';

class ProductCategoryList<T> extends StatelessWidget {
  const ProductCategoryList({
    required this.categories,
    required this.categoryToText,
    required this.selectedCategory,
    required this.onChanged,
    super.key,
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
              child: ProductCategoryListItem(
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
