import 'dart:async';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(Request request) async {
  _logRequestDetails(request);
  return request;
}

void _logRequestDetails(Request request) {
  print('========== Request Interceptor Start ==========');
  print('Method: ${request.method}');
  print('URL: ${request.url}');
  print('Headers: ${request.headers}');
  print('========== Request Interceptor End ==========');
}
