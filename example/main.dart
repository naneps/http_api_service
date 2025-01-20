import 'package:api_service_example/api_service_example.dart';
import 'package:http_api_service/http_api_service.dart';

/// The main function serves as the entry point for the Dart application.
///
/// It performs the following operations:
///
/// 1. Creates an instance of `PostService`.
/// 2. Fetches posts using `fetchPosts` method.
/// 3. Creates a new post with the title 'New Post' using `createPost` method.
/// 4. Updates the post with ID 1 to have the title 'Updated Post' using `updatePost` method.
/// 5. Deletes the post with ID 1 using `deletePost` method.
/// 6. Fetches the post with ID 1 using `fetchPost` method.
/// 7. Prints 'Done.' to the console.
/// 8. Creates an instance of `ApiService` with the base URL 'https://jsonplaceholder.typicode.com'.
/// 9. Attempts to fetch the post with ID 1 from the API and prints the response body.
/// 10. Catches and prints any errors that occur during the API request.
void main() async {
  final postService = PostService();
  await postService.fetchPosts();
  await postService.createPost('New Post');
  await postService.updatePost(1, 'Updated Post');
  await postService.deletePost(1);
  await postService.fetchPost(1);

  print('Done.');

  final apiService =
      ApiService(baseUrl: 'https://jsonplaceholder.typicode.com');

  try {
    final response = await apiService.get('/posts/1');
    print(response.body);
  } catch (e) {
    print('Error: $e');
  }
}
