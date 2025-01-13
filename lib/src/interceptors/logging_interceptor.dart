class LoggingInterceptor {
  static void logRequest(String method, Uri url,
      {Map<String, String>? headers, dynamic body}) {
    print('--- REQUEST ---');
    print('Method: $method');
    print('URL: $url');
    if (headers != null) print('Headers: $headers');
    if (body != null) print('Body: $body');
    print('----------------');
  }

  static void logResponse(int statusCode, {dynamic body}) {
    print('--- RESPONSE ---');
    print('Status Code: $statusCode');
    if (body != null) print('Body: $body');
    print('----------------');
  }
}
