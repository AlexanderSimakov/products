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
      child: IconButton.filled(
        onPressed: onTap,
        icon: const Icon(Icons.add),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xFFFFF2E7),
          foregroundColor: context.colorScheme.primary,
          iconSize: 20,
        ),
      ),
    );
  }
}
