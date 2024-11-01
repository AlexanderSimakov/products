import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';
import 'package:product_basket/src/common/utils/svg_cache_util.dart';
import 'package:product_basket/src/features/basket/data/data_source/basket_data_source_impl.dart';
import 'package:product_basket/src/features/basket/data/data_source/products_data_source_impl.dart';
import 'package:product_basket/src/features/basket/data/repository/basket_repository_impl.dart';
import 'package:product_basket/src/features/basket/data/repository/products_repository_impl.dart';
import 'package:product_basket/src/features/basket/domain/interactor/basket_interactor.dart';
import 'package:product_basket/src/features/basket/domain/interactor/products_interactor.dart';
import 'package:product_basket/src/features/basket/presentation/page/basket_page.dart';
import 'package:product_basket/src/features/basket/presentation/scope/basket_bloc_scope.dart';
import 'package:product_basket/src/features/basket/presentation/scope/products_bloc_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await PrecacheSvgUtil.precacheAll();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsInteractor>(
          create: (context) => ProductsInteractor(
            repository: ProductsRepositoryImpl(
              dataSource: ProductsDataSourceImpl(),
            ),
          ),
        ),
        RepositoryProvider<BasketInteractor>(
          create: (context) => BasketInteractor(
            repository: BasketRepositoryImpl(
              dataSource: BasketDataSourceImpl(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        home: const ProductsBlocScope(
          child: BasketBlocScope(
            child: BasketPage(),
          ),
        ),
      ),
    );
  }
}
