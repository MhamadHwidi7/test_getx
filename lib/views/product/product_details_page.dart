import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_test/controllers/products/ProductController.dart';
import 'package:ecommerce_test/models/products/ProductModel.dart';
import 'package:ecommerce_test/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['id'] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    controller.fetchProduct(int.parse(Get.parameters['id']!));

    final theme = Theme.of(context);
    final isDarkMode = Get.isDarkMode;

    return controller.obx(
      (state) {
        if (state == null) return _isLoading(isDarkMode: isDarkMode);
        return _buildPageContent(context: context, product: state, theme: theme, isDarkMode: isDarkMode);
      },
      onLoading: _isLoading(isDarkMode: isDarkMode),
    );
  }

  Widget _buildPageContent({
    required BuildContext context,
    required ProductModel product,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, product, isDarkMode),
          _buildProductDetails(product, theme),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ProductModel product, bool isDarkMode) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      elevation: 0,
      snap: true,
      floating: true,
      stretch: true,
      backgroundColor: Colors.grey.shade50,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: CachedNetworkImage(
          imageUrl: product.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => _isLoading(isDarkMode: isDarkMode),
          errorWidget: (context, url, error) => _isLoading(isDarkMode: isDarkMode),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: Container(
          height: 45,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(ProductModel product, ThemeData theme) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrand(product),
              const SizedBox(height: 8),
              _buildName(product, theme),
              const SizedBox(height: 8),
              _buildRatingRow(product),
              const SizedBox(height: 16),
              _buildPriceAndQuantity(product),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 30),
              _buildColorOptions(product),
              const SizedBox(height: 10),
              _buildSizeOptions(product),
              const SizedBox(height: 20),
              _buildAddToCartButton(),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildBrand(ProductModel product) {
    return Text(
      product.brand,
      style: TextStyle(
        color: Colors.orange.shade400,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildName(ProductModel product, ThemeData theme) {
    return Text(
      product.name,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRatingRow(ProductModel product) {
    return Row(
      children: [
        Text(
          product.rating.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        ...List.generate(4, (index) => Icon(Icons.star, size: 18, color: Colors.orange.shade400)),
        Icon(Icons.star, size: 18, color: Colors.orange.shade100),
      ],
    );
  }

  Widget _buildPriceAndQuantity(ProductModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${product.price}${TextConstants.priceFormat}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        _buildQuantityAdjuster(),
      ],
    );
  }

  Widget _buildQuantityAdjuster() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 32,
      child: Row(
        children: [
          ZoomTapAnimation(
            onTap: () => controller.decrement(),
            child: const Icon(Icons.remove, size: 18),
          ),
          const SizedBox(width: 4),
          Container(
            width: 30,
            height: 10,
            alignment: Alignment.center,
            child: TextField(
              controller: controller.quantityController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          const SizedBox(width: 4),
          ZoomTapAnimation(
            onTap: () => controller.increment(),
            child: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      TextConstants.description,
      style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15),
    );
  }

  Widget _buildColorOptions(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(TextConstants.color),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
        
children: product.colors?.map((colorName) {
  final color = getColorFromName(colorName) ?? Colors.transparent;
  return GestureDetector(
    onTap: () {
      controller.selectColor(colorName);
    },
    child: Obx(
      () => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: controller.selectedColor.value == colorName ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    ),
  );
}).toList() ?? [],

        ),
      ],
    );
  }

  Widget _buildSizeOptions(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(TextConstants.size),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
         children: product.sizes?.map((size) {
  return GestureDetector(
    onTap: () {
      controller.selectSize(size);
    },
    child: Obx(() => Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: controller.selectedSize.value == size ? Colors.black : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: controller.selectedSize.value == size ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    )),
  );
}).toList() ?? [],

        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey.shade400, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildAddToCartButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(Get.context!);
      },
      height: 50,
      elevation: 0,
      splashColor: Colors.yellow[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.yellow[800],
      child: Center(
        child: Text(
          TextConstants.addToCart,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _isLoading({required bool isDarkMode}) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: isDarkMode ? Colors.white : Colors.blue)),
    );
  }

Color? getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'grey':
      return Colors.grey;
    default:
      return null;
  }
}

}
