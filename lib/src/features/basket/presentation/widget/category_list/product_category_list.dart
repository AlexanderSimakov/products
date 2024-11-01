import 'package:flutter/material.dart';
import 'package:product_basket/src/common/extension/theme_extension.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/utils/category_extension.dart';

part 'product_category_list_item.dart';

class ProductCategoryList extends StatelessWidget {
  const ProductCategoryList({
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
    super.key,
  });

  final List<Category> categories;
  final Category selectedCategory;
  final ValueChanged<Category> onChanged;

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
              child: _ProductCategoryListItem(
                key: ObjectKey(category),
                title: category.toText(),
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
