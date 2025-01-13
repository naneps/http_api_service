import 'package:api_service/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final apiService =
      ApiService(baseUrl: 'https://jsonplaceholder.typicode.com');
  test('request get api', () async {
    final response = await apiService.get('/posts');
    expect(response.statusCode, 200);
  });

  test('request post api', () async {
    final response = await apiService.post('/posts', body: {'title': 'title'});
    expect(response.statusCode, 201);
  });

  test('request put api', () async {
    final response = await apiService.put('/posts/1', body: {'title': 'title'});
    expect(response.statusCode, 200);
  });

  test('request delete api', () async {
    final response = await apiService.delete('/posts/1');
    expect(response.statusCode, 200);
  });
}
