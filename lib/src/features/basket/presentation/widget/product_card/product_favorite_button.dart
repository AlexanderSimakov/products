part of 'product_card.dart';

class _ProductFavoriteButton extends StatelessWidget {
  const _ProductFavoriteButton({
    required this.onIsFavoriteChanged,
    required this.isFavorite,
  });

  final ValueChanged<bool> onIsFavoriteChanged;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onIsFavoriteChanged(!isFavorite);
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        color: const Color(0xFFFFA451),
        size: 24,
      ),
    );
  }
}
