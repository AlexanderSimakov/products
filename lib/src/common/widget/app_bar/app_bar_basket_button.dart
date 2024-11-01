import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/common/extension/theme_extension.dart';
import 'package:product_basket/src/common/widget/popup/popup.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';

class AppBarBasketButton extends StatelessWidget {
  const AppBarBasketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BasketBloc, BasketState, int>(
      selector: (state) => state.basket.products.length,
      builder: (context, productsCount) {
        return Popup(
          followerAnchor: Alignment.topLeft,
          follower: (context, controller) {
            Future.delayed(
              const Duration(milliseconds: 2000),
              () {
                controller.hide();
              },
            );
            return TapRegion(
              onTapOutside: (_) {
                controller.hide();
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    'Basket is empty',
                    style: TextStyle(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            );
          },
          child: (context, portalController) {
            return GestureDetector(
              onTap: () {
                if (productsCount == 0) {
                  portalController.show();
                } else {
                  context.read<BasketBloc>().add(const BasketClear());
                }
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.basketSvgIcon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Text(
                        'My Basket',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  if (productsCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: context.colorScheme.error,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: FittedBox(
                          child: Text(
                            productsCount.toString(),
                            style: TextStyle(
                              color: context.colorScheme.onError,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
