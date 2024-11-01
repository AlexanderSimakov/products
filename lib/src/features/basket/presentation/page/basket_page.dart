import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/features/basket/domain/model/category.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';
import 'package:product_basket/src/features/basket/presentation/page/search_page.dart';
import 'package:product_basket/src/features/basket/presentation/scope/basket_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_search_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/widget/app_dialog.dart';
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
    return BlocListener<BasketBloc, BasketState>(
      listener: (context, state) {
        if (state is BasketProductAdded) {
          AppDialog.show(
            context: context,
            title: '${state.product.name} Added!',
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  AppAssets.appBarDrawerSvgIcon,
                  width: 22,
                  height: 11,
                ),
              );
            },
          ),
          actions: const [
            BasketButton(),
          ],
        ),
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: GreetingText(name: 'Kante'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Hero(
                  tag: 'search_bar',
                  child: AppSearchBar(
                    onTap: () {
                      _openSearchPage(context);
                    },
                    overridedOnFilterTap: () {
                      _openSearchPage(context);
                    },
                  ),
                ),
              ),
              const Spacer(),
              const RecomendedBlock(),
              const Spacer(),
              const ProductByCategoryBlock(),
            ],
          ),
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

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    this.onTap,
    this.overridedOnFilterTap,
    this.onSearchQueryChanged,
    this.onSearchFilterChanged,
    this.requestFocus = false,
    this.initialFilter,
    super.key,
  });

  final VoidCallback? onTap;
  final VoidCallback? overridedOnFilterTap;
  final ValueChanged<String>? onSearchQueryChanged;
  final ValueChanged<List<Category>>? onSearchFilterChanged;
  final List<Category>? initialFilter;
  final bool requestFocus;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          Expanded(
            child: SearchTextField(
              onChanged: onSearchQueryChanged,
              onTap: onTap,
              requestFocus: requestFocus,
            ),
          ),
          const SizedBox(width: 10),
          FilterButton(
            initialFilter: initialFilter,
            onFilterChanged: onSearchFilterChanged,
            overridedOnTap: overridedOnFilterTap,
          ),
        ],
      ),
    );
  }
}
