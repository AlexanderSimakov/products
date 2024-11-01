part of 'product_card.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    required this.price,
    super.key,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${price.currency} ',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFA451),
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
