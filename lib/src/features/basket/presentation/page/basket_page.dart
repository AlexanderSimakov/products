import 'package:flutter/material.dart';
import 'package:product_basket/src/features/basket/domain/model/price.dart';
import 'package:product_basket/src/features/basket/domain/model/product.dart';
import 'package:product_basket/src/features/basket/presentation/widget/basket_button.dart';
import 'package:product_basket/src/features/basket/presentation/widget/custom_app_bar.dart';
import 'package:product_basket/src/features/basket/presentation/widget/filter_button.dart';
import 'package:product_basket/src/features/basket/presentation/widget/greeting_text.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_by_category_block.dart';
import 'package:product_basket/src/features/basket/presentation/widget/recomended_block.dart';
import 'package:product_basket/src/features/basket/presentation/widget/search_text_field.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        actions: [
          BasketButton(),
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: GreetingText(name: 'Kante'),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SearchTextField(),
                  ),
                  SizedBox(width: 10),
                  FilterButton(),
                ],
              ),
            ),
            Spacer(),
            RecomendedBlock(
              products: [
                Product(
                  id: '1',
                  name: 'Combo',
                  price: Price(100, r'$'),
                  imageUrl:
                      'https://clipart-library.com/image_gallery2/Salad-PNG-Image.png',
                  isFavorite: false,
                ),
                Product(
                  id: '2',
                  name: 'Combo',
                  price: Price(100, r'$'),
                  imageUrl:
                      'https://static.vecteezy.com/system/resources/thumbnails/018/128/193/small/delicious-spinach-salad-with-fresh-png.png',
                  isFavorite: false,
                ),
              ],
            ),
            Spacer(),
            ProductByCategoryBlock(),
          ],
        ),
      ),
    );
  }
}
