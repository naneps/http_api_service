import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_api_service/http_api_service.dart';

/// A service class responsible for handling API requests.
///
/// This class provides methods to interact with a remote server,
/// making HTTP requests and processing responses.
///
/// Example usage:
/// ```dart
/// final apiService = ApiService();
/// final data = await apiService.fetchData();
/// ```
///
/// Note: Ensure that you have proper error handling and
/// network connectivity checks when using this service.
class ApiService {
  /// A service class to handle API requests.
  ///
  /// The [ApiService] class provides a way to configure and make HTTP requests
  /// to a specified base URL with optional default headers.
  ///
  /// Example usage:
  /// ```dart
  /// final apiService = ApiService(
  ///   baseUrl: 'https://api.example.com',
  ///   defaultHeaders: {
  ///     'Authorization': 'Bearer your_token',
  ///   },
  /// );
  /// ```
  ///
  /// The [baseUrl] parameter is required and specifies the base URL for the API.
  /// The [defaultHeaders] parameter is optional and allows you to specify
  /// default headers that will be included in every request.
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({
    required this.baseUrl,
    this.defaultHeaders = const {},
  });

  /// Sends a DELETE request to the specified [endpoint].
  ///
  /// Optionally, you can provide [headers] and [queryParameters] to include in the request.
  ///
  /// Returns a [Future] that completes with the [http.Response] from the server.
  ///
  /// Example usage:
  /// ```dart
  /// final response = await apiService.delete(
  ///   '/example-endpoint',
  ///   headers: {'Authorization': 'Bearer token'},
  ///   queryParameters: {'key': 'value'},
  /// );
  /// ```

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

  /// Sends a GET request to the specified [endpoint].
  ///
  /// Optionally, you can provide [headers] and [queryParameters] to include in the request.
  ///
  /// Returns a [Future] that resolves to an [http.Response] containing the response from the server.
  ///
  /// Example usage:
  /// ```dart
  /// final response = await apiService.get(
  ///   'https://example.com/api/data',
  ///   headers: {'Authorization': 'Bearer token'},
  ///   queryParameters: {'key': 'value'},
  /// );
  /// ```

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

  /// Sends a POST request to the specified [endpoint].
  ///
  /// The [endpoint] parameter specifies the path of the API endpoint.
  ///
  /// The [headers] parameter allows you to specify additional HTTP headers.
  ///
  /// The [body] parameter allows you to specify the request payload, which will be JSON-encoded.
  ///
  /// The [queryParameters] parameter allows you to specify query parameters to be appended to the URL.
  ///
  /// Returns a [Future] that completes with the [http.Response] from the server.
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

  /// Sends a PUT request to the specified [endpoint].
  ///
  /// The [endpoint] parameter specifies the path of the API endpoint.
  ///
  /// The optional [headers] parameter allows you to specify additional headers
  /// for the request.
  ///
  /// The optional [body] parameter allows you to specify the body of the request,
  /// which will be JSON-encoded.
  ///
  /// The optional [queryParameters] parameter allows you to specify query
  /// parameters to be appended to the endpoint URL.
  ///
  /// Returns a [Future] that completes with the [http.Response] from the server.

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

  /// Builds a [Uri] object by combining the [baseUrl] with the given [endpoint]
  /// and optional [queryParameters].
  ///
  /// The [endpoint] is a string that represents the path to be appended to the
  /// base URL.
  ///
  /// The [queryParameters] is a map of key-value pairs that will be added as
  /// query parameters to the URI. If the [queryParameters] is null, no query
  /// parameters will be added.
  ///
  /// Returns a [Uri] object with the combined base URL, endpoint, and query
  /// parameters.
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    return Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters?.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
  }

  /// Handles an HTTP request and processes the response.
  ///
  /// This method takes a function that returns a `Future<http.Response>`,
  /// executes it, logs the response, and then parses the response.
  ///
  /// If the request fails, an exception is thrown.
  ///
  /// - Parameter request: A function that returns a `Future<http.Response>`.
  /// - Returns: A `Future<http.Response>` that completes with the parsed response.
  /// - Throws: An `Exception` if the request fails.

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

  /// Merges the provided headers with the default headers.
  ///
  /// If the provided headers are `null`, only the default headers will be returned.
  ///
  /// - Parameter headers: A map of headers to merge with the default headers.
  /// - Returns: A map containing the merged headers.

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {
      ...defaultHeaders,
      if (headers != null) ...headers,
    };
  }

  /// Parses the HTTP response and throws appropriate exceptions based on the status code.
  ///
  /// - Returns: The original [http.Response] if the status code indicates success (200 or 201).
  /// - Throws:
  ///   - [BadRequestException] if the status code is 400.
  ///   - [UnauthorizedException] if the status code is 401.
  ///   - [ForbiddenException] if the status code is 403.
  ///   - [NotFoundException] if the status code is 404.
  ///   - [InternalServerErrorException] if the status code is 500.
  ///   - [ApiException] for any other unexpected status codes.
  ///
  /// - Parameters:
  ///   - response: The [http.Response] to be parsed.

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
