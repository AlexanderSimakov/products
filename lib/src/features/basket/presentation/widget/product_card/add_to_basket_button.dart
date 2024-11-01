part of 'product_card.dart';

class _AddToBasketButton extends StatelessWidget {
  const _AddToBasketButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2E7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            Icons.add,
            size: 20,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
