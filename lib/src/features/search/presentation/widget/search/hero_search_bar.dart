import 'package:flutter/material.dart';
import 'package:product_basket/src/features/products/domain/model/category.dart';
import 'package:product_basket/src/features/search/presentation/widget/search/app_search_bar.dart';

class HeroSearchBar extends StatelessWidget {
  const HeroSearchBar({
    this.onTap,
    this.onQueryChanged,
    this.onFilterChanged,
    this.initialFilter,
    super.key,
  });

  final VoidCallback? onTap;
  final ValueChanged<String>? onQueryChanged;
  final ValueChanged<List<Category>>? onFilterChanged;
  final List<Category>? initialFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        ignoring: onTap != null,
        child: Hero(
          tag: 'search_bar',
          child: Material(
            type: MaterialType.transparency,
            child: AppSearchBar(
              onQueryChanged: onQueryChanged,
              initialFilter: initialFilter,
              onFilterChanged: onFilterChanged,
            ),
          ),
        ),
      ),
    );
  }
}
