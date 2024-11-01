part of 'product_category_list.dart';

class _ProductCategoryListItem extends StatelessWidget {
  const _ProductCategoryListItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: isSelected ? 24 : 16,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? context.colorScheme.onSurface
                  : context.colorScheme.onSurfaceVariant,
            ),
            child: Text(title),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected ? 3 : 0,
            width: isSelected ? 36 : 0,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
