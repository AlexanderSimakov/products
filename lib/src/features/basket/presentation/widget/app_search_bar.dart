import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/widget/filter_button.dart';
import 'package:product_basket/src/features/basket/presentation/widget/search_text_field.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.onSearchQueryChanged,
    required this.requestFocus,
    required this.initialFilter,
    required this.onSearchFilterChanged,
    super.key,
  });

  final ValueChanged<String>? onSearchQueryChanged;
  final bool requestFocus;
  final List<Category>? initialFilter;
  final ValueChanged<List<Category>>? onSearchFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchTextField(
            onChanged: onSearchQueryChanged,
            requestFocus: requestFocus,
          ),
        ),
        const SizedBox(width: 10),
        FilterButton(
          initialFilter: initialFilter,
          onFilterChanged: onSearchFilterChanged,
        ),
      ],
    );
  }
}
