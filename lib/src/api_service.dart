import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_api_service/http_api_service.dart';

class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({
    required this.baseUrl,
    this.defaultHeaders = const {},
  });

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.delete(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
      ),
    );
  }

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.get(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
      ),
    );
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.post(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
        body: jsonEncode(body),
      ),
    );
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.put(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
        body: jsonEncode(body),
      ),
    );
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    return Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters?.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
  }

  Future<http.Response> _handleRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      // Logging request and response
      LoggingInterceptor.logResponse(response.statusCode, body: response.body);

      // Memanggil _parseResponse untuk menangani exception
      return _parseResponse(response);
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {
      ...defaultHeaders,
      if (headers != null) ...headers,
    };
  }

  http.Response _parseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response; // Response sukses, langsung kembalikan
      case 400:
        throw BadRequestException('Bad Request: ${response.body}');
      case 401:
        throw UnauthorizedException('Unauthorized: ${response.body}');
      case 403:
        throw ForbiddenException('Forbidden: ${response.body}');
      case 404:
        throw NotFoundException('Not Found: ${response.body}');
      case 500:
        throw InternalServerErrorException(
            'Internal Server Error: ${response.body}');
      default:
        throw ApiException('Unexpected error: ${response.statusCode}',
            statusCode: response.statusCode);
    }
  }
}
