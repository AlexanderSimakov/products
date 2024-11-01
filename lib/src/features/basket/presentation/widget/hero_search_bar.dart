import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/widget/app_search_bar.dart';

class HeroSearchBar extends StatelessWidget {
  const HeroSearchBar({
    this.onTap,
    this.onSearchQueryChanged,
    this.onSearchFilterChanged,
    this.requestFocus = false,
    this.initialFilter,
    super.key,
  });

  final VoidCallback? onTap;
  final ValueChanged<String>? onSearchQueryChanged;
  final ValueChanged<List<Category>>? onSearchFilterChanged;
  final List<Category>? initialFilter;
  final bool requestFocus;

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
              onSearchQueryChanged: onSearchQueryChanged,
              requestFocus: requestFocus,
              initialFilter: initialFilter,
              onSearchFilterChanged: onSearchFilterChanged,
            ),
          ),
        ),
      ),
    );
  }
}
