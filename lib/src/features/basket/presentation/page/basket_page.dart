import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_basket/src/features/basket/domain/interactor/basket_interactor.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';
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
      child: const Scaffold(
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
              RecomendedBlock(),
              Spacer(),
              ProductByCategoryBlock(),
            ],
          ),
        ),
      ),
    );
  }
}
