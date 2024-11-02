import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce_test/models/categories/CategoryModel.dart';
import 'package:ecommerce_test/models/offers/OfferModel.dart';
import 'package:ecommerce_test/models/products/ProductModel.dart';
import 'package:ecommerce_test/providers/category_provider.dart';
import 'package:ecommerce_test/providers/offer_provider.dart';
import 'package:ecommerce_test/providers/product_provider.dart';
import 'package:ecommerce_test/views/home/tabs/card_tab.dart';
import 'package:ecommerce_test/views/home/tabs/explore_tab.dart';
import 'package:ecommerce_test/views/home/tabs/user_tab.dart';
import 'package:ecommerce_test/views/home/tabs/bookmarked_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final OfferProvider _offerProvider;
  HomeController(this._offerProvider);

  late PageController pageController;
  late CarouselSliderController carouselController;
  late CategoryProvider _categoryProvider = Get.find();
  late ProductProvider _productProvider = Get.find();

  var currentPage = 0.obs;
  var currentBanner = 0.obs;
  var activeOffers = <OfferModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var discountedProducts = <ProductModel>[].obs;

  List<Widget> pages = [
    ExploreTab(),
     const BookmarkedTab(),
    const CardTab(),
    UserTab(),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    carouselController = CarouselSliderController();

    getOffers();
    getCategories();
    getDiscountedProducts();
    super.onInit();
  }

  void getOffers() {
    _offerProvider.getOffers().then((offers) {
      activeOffers.value = offers;
    });
  }

  void getCategories() {
    _categoryProvider.getCategories().then((categories) {
      this.categories.value = categories;
    });
  }

  void getDiscountedProducts() {
    _productProvider.getDiscountedProducts().then((products) {
      discountedProducts(products);
      print(products);
    });
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}
