import 'package:ecommerce_test/models/products/ProductModel.dart';
import 'package:ecommerce_test/repositories/product_repository.dart';

class ProductProvider {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);

  Future<List<ProductModel>> getDiscountedProducts() async {
    var products = await _productRepository.getDiscountedProducts();

    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    var product = await _productRepository.getProductId(id);

    return ProductModel.fromJson(product);
  }
}
