import 'package:ecommerce_test/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BookmarkedTab extends StatelessWidget {
  const BookmarkedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 10),
            _buildMessage(),
           
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      IconlyLight.heart,
      size: 80,
      color: Colors.green.shade400,
    );
  }

  Widget _buildTitle() {
    return const Text(
      TextConstants.noFavoritesTitle,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF424242),
      ),
    );
  }

  Widget _buildMessage() {
    return const Text(
      TextConstants.noFavoritesMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF757575),
      ),
    );
  }
}
