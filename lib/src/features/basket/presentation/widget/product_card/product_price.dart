part of 'product_card.dart';

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${price.currency} ',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.colorScheme.primary,
        ),
        children: [
          TextSpan(
            text: price.value.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
