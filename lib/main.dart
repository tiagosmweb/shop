import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_details.dart';
import 'package:shop/utils/app_routes.dart';
import 'pages/products_overview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.purple, accentColor: Colors.deepOrange)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewPage(),
        routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDatailsPage()},
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
