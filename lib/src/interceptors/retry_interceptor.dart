import 'dart:async';

class RetryInterceptor {
  static Future<T> retry<T>(
    Future<T> Function() request, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    int retries = 0;

    while (retries < maxRetries) {
      try {
        return await request();
      } catch (e) {
        retries++;
        if (retries == maxRetries) rethrow;
        await Future.delayed(delay);
        print('Retrying... ($retries/$maxRetries)');
      }
    }

    throw Exception('Retry limit reached');
  }
}
