import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';

class AppBarDrawerButton extends StatelessWidget {
  const AppBarDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}
