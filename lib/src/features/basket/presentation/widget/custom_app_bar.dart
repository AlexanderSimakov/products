import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.actions,
    super.key,
  });

  final List<Widget> actions;

  @override
  Size get preferredSize => const Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset(
                AppAssets.appBarDrawerIcon,
                width: 22,
                height: 11,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
