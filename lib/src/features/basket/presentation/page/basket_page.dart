import 'package:flutter/material.dart';
import 'package:product_basket/src/common/widget/app_bar/app_bar_basket_button.dart';
import 'package:product_basket/src/common/widget/app_bar/app_bar_drawer_button.dart';
import 'package:product_basket/src/common/widget/app_bar/custom_app_bar.dart';
import 'package:product_basket/src/common/widget/app_scaffold.dart';
import 'package:product_basket/src/features/basket/presentation/page/search_page.dart';
import 'package:product_basket/src/features/basket/presentation/scope/basket_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/product_added_dialog_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_search_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/widget/greeting_module.dart';
import 'package:product_basket/src/features/basket/presentation/widget/product_by_category_module.dart';
import 'package:product_basket/src/features/basket/presentation/widget/recommended_products_module.dart';
import 'package:product_basket/src/features/basket/presentation/widget/search/hero_search_bar.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProductAddedDialogScope(
      child: AppScaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          leading: AppBarDrawerButton(),
          actions: [AppBarBasketButton()],
        ),
        drawer: const Drawer(),
        body: Column(
          children: [
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GreetingModule(
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
            const RecomendedProductsModule(),
            const Spacer(),
            const ProductByCategoryModule(),
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
