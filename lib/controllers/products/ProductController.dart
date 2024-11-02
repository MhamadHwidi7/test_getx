import 'package:ecommerce_test/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController with StateMixin {
  final ProductProvider _productProvider;
  final TextEditingController quantityController = TextEditingController();

  ProductController(this._productProvider);

  // Observables
  var count = 1.obs;
  var selectedColor = ''.obs;
  var selectedSize = ''.obs;

  @override
  void onInit() {
    quantityController.text = count.value.toString();
    super.onInit();
  }
  
  // Fetch Product details by ID
  void fetchProduct(int id) {
    change(null, status: RxStatus.loading());
    _productProvider.getProductById(id).then((product) {
      change(product, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
    });
  }

  // Increment quantity
  void increment() {
    count.value++;
    updateQuantity();
  }

  // Decrement quantity
  void decrement() {
    if (count.value > 1) {
      count.value--;
      updateQuantity();
    }
  }

  // Update quantity text controller
  void updateQuantity() {
    quantityController.text = count.value.toString();
  }

  // Select color for the product
  void selectColor(String color) {
    selectedColor.value = color;
  }

  // Select size for the product
  void selectSize(String size) {
    selectedSize.value = size;
  }

  @override
  void onClose() {
    quantityController.dispose();
    super.onClose();
  }
}
