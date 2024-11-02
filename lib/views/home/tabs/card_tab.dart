import 'package:ecommerce_test/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CardTab extends StatelessWidget {
  const CardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 10),
            _buildMessage(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return const Icon(
      IconlyLight.bag,
      size: 80,
      color: Colors.red,
    );
  }

  Widget _buildTitle() {
    return const Text(
      TextConstants.emptyCartTitle,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF424242),
      ),
    );
  }

  Widget _buildMessage() {
    return const Text(
      TextConstants.emptyCartMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF757575),
      ),
    );
  }
}
