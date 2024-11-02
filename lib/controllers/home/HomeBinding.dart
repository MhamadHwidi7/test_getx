import 'package:ecommerce_test/controllers/home/HomeController.dart';
import 'package:ecommerce_test/providers/category_provider.dart';
import 'package:ecommerce_test/providers/offer_provider.dart';
import 'package:ecommerce_test/providers/product_provider.dart';
import 'package:ecommerce_test/repositories/category_repository.dart';
import 'package:ecommerce_test/repositories/offer_repository.dart';
import 'package:ecommerce_test/repositories/product_repository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferRepository>(() => OfferRepository(Get.find()));
    Get.lazyPut<OfferProvider>(() => OfferProvider(Get.find()));

    Get.lazyPut<CategoryRepository>(() => CategoryRepository(Get.find()));
    Get.lazyPut<CategoryProvider>(() => CategoryProvider(Get.find()));
    
    Get.lazyPut<ProductRepository>(() => ProductRepository(Get.find()));
    Get.lazyPut<ProductProvider>(() => ProductProvider(Get.find()));
    
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
