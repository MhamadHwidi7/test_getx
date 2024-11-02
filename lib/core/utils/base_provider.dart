import 'package:ecommerce_test/core/api/api_constants.dart';
import 'package:get/get_connect.dart';
import 'package:ecommerce_test/core/interceptors/request_interceptor.dart';
import 'package:ecommerce_test/core/interceptors/response_interceptor.dart';

class BaseProvider extends GetConnect {
  BaseProvider({String? baseUrl}) {
    httpClient.baseUrl = baseUrl ?? ApiConstants.baseUrl;
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
