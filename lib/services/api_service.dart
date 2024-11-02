import 'package:ecommerce_test/core/utils/base_provider.dart';
import 'package:ecommerce_test/core/typedef.dart';
import 'package:get/get.dart';

class ApiService {
  final BaseProvider _baseProvider;

  ApiService(this._baseProvider);

  Future<JSON> get({
    required String endpoint,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    return await _request(
      endpoint: endpoint,
      method: 'GET',
      query: query,
      headers: headers,
      requiresAuthToken: requiresAuthToken,
    );
  }

  Future<JSON> post({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    return await _request(
      endpoint: endpoint,
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
      requiresAuthToken: requiresAuthToken,
    );
  }

  Future<JSON> put({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    return await _request(
      endpoint: endpoint,
      method: 'PUT',
      body: body,
      query: query,
      headers: headers,
      requiresAuthToken: requiresAuthToken,
    );
  }

  Future<JSON> delete({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    return await _request(
      endpoint: endpoint,
      method: 'DELETE',
      body: body,
      query: query,
      headers: headers,
      requiresAuthToken: requiresAuthToken,
    );
  }

  Future<JSON> _request({
    required String endpoint,
    required String method,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    final customHeaders = _buildHeaders(headers, requiresAuthToken);

    late Response response;
    switch (method) {
      case 'GET':
        response = await _baseProvider.get(endpoint, headers: customHeaders, query: query);
        break;
      case 'POST':
        response = await _baseProvider.post(endpoint, body, headers: customHeaders, query: query);
        break;
      case 'PUT':
        response = await _baseProvider.put(endpoint, body, headers: customHeaders, query: query);
        break;
      case 'DELETE':
        response = await _baseProvider.delete(endpoint, headers: customHeaders, query: query);
        break;
      default:
        throw ArgumentError('Invalid HTTP method: $method');
    }

    return response.body;
  }

  Map<String, String> _buildHeaders(Map<String, String>? headers, bool requiresAuthToken) {
    final customHeaders = {
      'Accept': 'application/json',
    };

    if (requiresAuthToken) {
      customHeaders['Authorization'] = 'Bearer <your_auth_token>';
    }

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    return customHeaders;
  }
}
