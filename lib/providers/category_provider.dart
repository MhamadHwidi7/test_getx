import 'package:ecommerce_test/models/categories/CategoryModel.dart';
import 'package:ecommerce_test/repositories/category_repository.dart';

class CategoryProvider {
  final CategoryRepository _categoryRepository;

  CategoryProvider(this._categoryRepository);

  Future<List<CategoryModel>> getCategories() async {
    var categories = await _categoryRepository.getCategories();

    return categories.map((category) => CategoryModel.fromJson(category)).toList();
  }
}
