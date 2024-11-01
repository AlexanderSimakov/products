import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/common/extension/theme_extension.dart';
import 'package:product_basket/src/common/widget/chip_multi_selector.dart';
import 'package:product_basket/src/features/products/domain/model/category.dart';
import 'package:product_basket/src/features/products/presentation/utils/category_extension.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.onFilterChanged,
    this.initialFilter,
    super.key,
  });

  final ValueChanged<List<Category>>? onFilterChanged;
  final List<Category>? initialFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final categories = await ChipMultiSelector.show<Category>(
          context: context,
          possibleValues: Category.values,
          title: 'Filter',
          toText: (value) => value.toText(),
          selectedValues: initialFilter ?? [],
        );
        if (categories != null) {
          onFilterChanged?.call(categories);
        }
      },
      child: SizedBox(
        height: 48,
        child: Stack(
          children: [
            Align(
              child: SvgPicture.asset(
                AppAssets.filterSvgIcon,
                width: 24,
                height: 24,
              ),
            ),
            if (initialFilter != null && initialFilter!.isNotEmpty)
              Positioned(
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: FittedBox(
                    child: Text(
                      initialFilter!.length.toString(),
                      style: TextStyle(
                        color: context.colorScheme.onError,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
