import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_test/controllers/home/HomeController.dart';
import 'package:ecommerce_test/models/categories/CategoryModel.dart';
import 'package:ecommerce_test/models/offers/OfferModel.dart';
import 'package:ecommerce_test/core/constants/color_constants.dart';
import 'package:ecommerce_test/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ExploreTab extends GetView<HomeController> {
  ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    _buildOfferCarousel(),
                    _buildOfferIndicator(),
                    const SizedBox(height: 16),
                    _buildSection(TextConstants.topCategories, theme),
                    const SizedBox(height: 8),
                    _buildCategories(theme),
                    const SizedBox(height: 16),
                    _buildSection(TextConstants.discounts, theme),
                    const SizedBox(height: 8),
                    _buildDiscountedProducts(theme),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: TextConstants.searchHint,
                hintStyle: TextStyle(color: Colors.grey.shade600),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none,
              ),
            ),
          ),
          _buildFilterIcon(),
        ],
      ),
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(IconlyLight.filter, color: Colors.grey),
      ),
    );
  }

  Widget _buildOfferCarousel() {
    return Container(
      height: Get.height * 0.25,
      child: CarouselSlider.builder(
        carouselController: controller.carouselController,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 1,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          onPageChanged: (index, reason) => controller.changeBanner(index),
        ),
        itemCount: controller.activeOffers.length,
        itemBuilder: (context, index, _) => _buildOffer(controller.activeOffers[index]),
      ),
    );
  }

  Widget _buildOffer(OfferModel offer) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: offer.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildOfferIndicator() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.activeOffers.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Get.isDarkMode ? Colors.white : Colors.blueGrey)
                    .withOpacity(controller.currentBanner == entry.key ? 0.9 : 0.2),
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildSection(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 50,
            splashColor: theme.primaryColor.withAlpha(10),
            highlightColor: theme.primaryColor.withAlpha(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            child: Icon(
              IconlyLight.arrow_right,
              size: 20,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(ThemeData theme) {
    return Container(
      height: 60,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) => _buildCategory(controller.categories[index]),
      ),
    );
  }

  Widget _buildCategory(CategoryModel category) {
    return ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 300),
      endDuration: const Duration(milliseconds: 500),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: 60,
              imageUrl: category.image,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withAlpha(110),
                child: Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountedProducts(ThemeData theme) {
    return Container(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.discountedProducts.length,
        itemBuilder: (context, index) => _buildDiscountedProductCard(index),
      ),
    );
  }

  Widget _buildDiscountedProductCard(int index) {
    final product = controller.discountedProducts[index];
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () => Get.toNamed('/product/${product.id}'),
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.isDarkMode ? ColorConstants.gray700 : Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 150,
                width: double.infinity,
                imageUrl: product.image,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.brand,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          IconlyLight.arrow_right,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "\$${product.discountPrice}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
