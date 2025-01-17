import 'package:http_api_service/http_api_service.dart';

void main() async {
  // Initialize the ApiService with the base URL
  final apiService =
      ApiService(baseUrl: 'https://jsonplaceholder.typicode.com');

  try {
    // Perform a GET request
    final response = await apiService.get('/posts/1');
  } catch (e) {
    print('Error: $e');
  }

  try {
    // Perform a POST request
    final response = await apiService.post(
      '/posts',
      body: {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
    );
    print('Created Post: ${response.body}');
  } catch (e) {
    print('Error while creating post: $e');
  }
}
