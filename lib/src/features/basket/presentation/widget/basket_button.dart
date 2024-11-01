import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/common/widget/popup/popup.dart';
import 'package:product_basket/src/features/basket/presentation/bloc/basket/basket_bloc.dart';

class BasketButton extends StatelessWidget {
  const BasketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
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
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Basket is empty'),
                ),
              ),
            );
          },
          child: (context, portalController) {
            return GestureDetector(
              onTap: () {
                if (state.basket.products.isEmpty) {
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
                      ),
                      const Text(
                        'My Basket',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  if (state.basket.products.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: FittedBox(
                          child: Text(
                            state.basket.products.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              // fontSize: 10,
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
