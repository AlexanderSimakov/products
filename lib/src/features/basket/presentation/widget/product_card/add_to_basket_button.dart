part of 'product_card.dart';

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({
    required this.product,
    required this.onTap,
    super.key,
  });

  final Product product;
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
          child: const Icon(
            Icons.add,
            size: 20,
            color: Color(0xFFFFA451),
          ),
        ),
      ),
    );
  }
}
