import 'package:ecommerce_test/services/api_service.dart';
import 'package:ecommerce_test/core/utils/base_provider.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);
  }
}
