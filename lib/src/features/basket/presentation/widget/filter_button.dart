import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/utils/category_extension.dart';
import 'package:product_basket/src/features/basket/presentation/widget/filter_modal.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.onFilterChanged,
    this.overridedOnTap,
    this.initialFilter,
    super.key,
  });

  final ValueChanged<List<Category>>? onFilterChanged;
  final VoidCallback? overridedOnTap;
  final List<Category>? initialFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: overridedOnTap ??
          () async {
            final categories = await FilterModal.show<Category>(
              context: context,
              values: Category.values,
              title: 'Filter',
              valueToString: (value) => value.toText(),
              initialSelection: initialFilter ?? [],
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
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: FittedBox(
                    child: Text(
                      initialFilter!.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        // fontSize: 10,
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
