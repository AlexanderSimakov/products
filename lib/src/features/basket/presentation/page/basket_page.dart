import 'package:flutter/material.dart';
import 'package:product_basket/src/common/widget/app_bar_drawer_button.dart';
import 'package:product_basket/src/common/widget/app_scaffold.dart';
import 'package:product_basket/src/common/widget/custom_app_bar.dart';
import 'package:product_basket/src/features/basket/presentation/page/search_page.dart';
import 'package:product_basket/src/features/basket/presentation/scope/basket_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/product_added_dialog_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_search_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/widget/basket_button.dart';
import 'package:product_basket/src/features/basket/presentation/widget/greeting_text.dart';
import 'package:product_basket/src/features/basket/presentation/widget/hero_search_bar.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_by_category_block.dart';
import 'package:product_basket/src/features/basket/presentation/widget/recomended_block.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProductAddedDialogScope(
      child: AppScaffold(
        appBar: const CustomAppBar(
          leading: AppBarDrawerButton(),
          actions: [BasketButton()],
        ),
        drawer: const Drawer(),
        body: Column(
          children: [
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GreetingText(
                userName: 'Kante',
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: HeroSearchBar(
                onTap: () {
                  _openSearchPage(context);
                },
              ),
            ),
            const Spacer(),
            const RecomendedBlock(),
            const Spacer(),
            const ProductByCategoryBlock(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  void _openSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) {
          return const ProductsBlocScope(
            child: BasketBlocScope(
              child: ProductsSearchBlocScope(
                child: SearchPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
