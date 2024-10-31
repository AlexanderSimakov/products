import 'package:product_basket/src/features/basket/domain/model/category.dart';

extension CategoryExtension on Category {
  String toText() {
    return switch (this) {
      Category.hottest => 'Hottest',
      Category.popular => 'Popular',
      Category.newCombo => 'New combo',
      Category.top => 'Top',
    };
  }
}
