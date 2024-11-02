import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ecommerce_test/controllers/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController _homeController = Get.find();
  final List<TabItem<dynamic>> _navItems = const [
    TabItem(icon: IconlyLight.home, title: 'Home'),
    TabItem(icon: IconlyLight.bookmark, title: 'Bookmarks'),
    TabItem(icon: IconlyLight.buy, title: 'Shop'),
    TabItem(icon: IconlyLight.profile, title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildPageView(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => ConvexAppBar(
          style: TabStyle.flip,
          backgroundColor: Colors.white,
          activeColor: Colors.blue,
          color: Colors.grey,
          items: _navItems,
          height: 48,
          elevation: 5,
          curveSize: 70,
          onTap: (int index) {
            _homeController.goToTab(index);
          },
          initialActiveIndex: _homeController.currentPage.value,
        ));
  }

  Widget _buildPageView() {
    return PageView(
      controller: _homeController.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: _homeController.pages,
    );
  }
}
