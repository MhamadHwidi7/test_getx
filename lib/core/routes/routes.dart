import 'package:ecommerce_test/controllers/home/HomeBinding.dart';
import 'package:ecommerce_test/controllers/products/ProductBinding.dart';
import 'package:ecommerce_test/views/home/home_page.dart';
import 'package:ecommerce_test/views/product/product_details_page.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const INITIAL = '/home';

  static final routes = [
    GetPage(
      name: '/home', 
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/product/:id', 
      page: () => const ProductPage(),
      binding: ProductBinding(),
    )
  ];
}
