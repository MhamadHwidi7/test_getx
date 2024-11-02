import 'dart:async';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ecommerce_test/core/shared/widgets/common_widgets.dart';

FutureOr<dynamic> responseInterceptor(Request request, Response response) async {
  return _handleResponse(response);
}

dynamic _handleResponse(Response response) {
  _logResponseDetails(response);

  switch (response.statusCode) {
    case 200:
      return response;
    default:
      final errorMessage = 'Error occurred while fetching data: ${response.statusCode}';
      CommonWidgets.snackBar('Error', errorMessage);
      throw UnknownException(errorMessage);
  }
}

void _logResponseDetails(Response response) {
  const startLog = '\x1B[35m========== Response Start ==========\x1B[0m';
  const endLog = '\x1B[35m========== Response End ==========\x1B[0m';
  final statusColor = response.statusCode == 200 ? '\x1B[32m' : '\x1B[31m';
  
  print(startLog);
  print('Status Code: $statusColor${response.statusCode}\x1B[0m');
  print('Body: \x1B[34m${response.body}\x1B[0m');
  print(endLog);
}

// Exception Classes
class AppException implements Exception {
  final dynamic code;
  final String message;
  final dynamic details;

  AppException({this.code, required this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message\nDetails: $details";
  }
}

class UnknownException extends AppException {
  UnknownException(String message) : super(code: 010, message: message);
}
