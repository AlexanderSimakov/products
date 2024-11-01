import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';

abstract class PrecacheSvgUtil {
  static Future<void> precacheAll() async {
    await Future.wait([
      precacheSvg(AppAssets.appBarDrawerSvgIcon),
      precacheSvg(AppAssets.basketSvgIcon),
      precacheSvg(AppAssets.filterSvgIcon),
      precacheSvg(AppAssets.searchSvgIcon),
    ]);
  }

  static Future<void> precacheSvg(String assetName) async {
    final loader = SvgAssetLoader(assetName);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}
