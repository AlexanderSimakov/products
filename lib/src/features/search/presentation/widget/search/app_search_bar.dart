import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/features/products/domain/model/category.dart';
import 'package:product_basket/src/features/search/presentation/widget/search/filter_button.dart';

part 'search_text_field.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.onQueryChanged,
    required this.initialFilter,
    required this.onFilterChanged,
    super.key,
  });

  final ValueChanged<String>? onQueryChanged;
  final List<Category>? initialFilter;
  final ValueChanged<List<Category>>? onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SearchTextField(
            onChanged: onQueryChanged,
          ),
        ),
        const SizedBox(width: 10),
        FilterButton(
          initialFilter: initialFilter,
          onFilterChanged: onFilterChanged,
        ),
      ],
    );
  }
}
