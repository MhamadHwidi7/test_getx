import 'package:ecommerce_test/controllers/products/ProductController.dart';
import 'package:ecommerce_test/providers/product_provider.dart';
import 'package:ecommerce_test/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {  
    Get.lazyPut<ProductRepository>(() => ProductRepository(Get.find()));
    Get.lazyPut<ProductProvider>(() => ProductProvider(Get.find()));
    
    Get.lazyPut<ProductController>(() => ProductController(Get.find()));
  }
}
