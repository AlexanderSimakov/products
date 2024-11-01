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
          Text(
            title,
            style: TextStyle(
              fontSize: isSelected ? 24 : 16,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? context.colorScheme.onSurface
                  : context.colorScheme.onSurfaceVariant,
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
      ),
    );
  }
}
