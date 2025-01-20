import 'package:http_api_service/http_api_service.dart';

/// A wrapper class for demonstrating advanced ApiService usage.
///
/// This class provides methods to interact with a RESTful API using the
/// `http_api_service` package. It includes methods for fetching, creating,
/// updating, and deleting posts.
///
/// Example usage:
/// ```dart
/// final postService = PostService();
/// await postService.fetchPosts();
/// await postService.createPost('New Post');
/// await postService.updatePost(1, 'Updated Post');
/// await postService.deletePost(1);
/// ```
///
/// Methods:
/// - `fetchPosts`: Fetches a list of posts from the API.
/// - `createPost`: Creates a new post with the given title.
/// - `deletePost`: Deletes a post with the given ID.
/// - `fetchPost`: Fetches a single post with the given ID.
/// - `updatePost`: Updates a post with the given ID and new title.
class ExampleService {
  final ApiService apiService;

  /// Constructs an [ExampleService] instance with the given [baseUrl].
  ExampleService(String baseUrl) : apiService = ApiService(baseUrl: baseUrl);

  /// Fetches a list of posts from the API.
  Future<void> fetchPosts() async {
    try {
      final response = await apiService.get('/posts');
      print('Fetched Posts: ${response.body}');
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}

/// A service class for handling CRUD operations on posts.
///
/// This class extends the [ExampleService] and provides methods to create,
/// delete, fetch, and update posts using the provided API service.
class PostService extends ExampleService {
  /// Constructs a [PostService] instance with the base URL set to
  /// "https://jsonplaceholder.typicode.com".
  PostService() : super('https://jsonplaceholder.typicode.com');

  /// Creates a new post with the given [title].
  ///
  /// Sends a POST request to the '/posts' endpoint with the title in the body.
  /// Prints the created post's response body or an error message if the request fails.
  Future<void> createPost(String title) async {
    try {
      final response = await apiService.post(
        '/posts',
        body: {'title': title},
      );
      print('Created Post: ${response.body}');
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  /// Deletes a post with the given [postId].
  ///
  /// Sends a DELETE request to the '/posts/{postId}' endpoint.
  /// Prints the deleted post's response body or an error message if the request fails.
  Future<void> deletePost(int postId) async {
    try {
      final response = await apiService.delete('/posts/$postId');
      print('Deleted Post: ${response.body}');
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  /// Fetches a post with the given [postId].
  ///
  /// Sends a GET request to the '/posts/{postId}' endpoint.
  /// Returns the response if the request is successful, otherwise throws an exception.
  Future<Response> fetchPost(int postId) async {
    try {
      final response = await apiService.get('/posts/$postId');
      return response;
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

  /// Updates a post with the given [postId] and [title].
  ///
  /// Sends a PUT request to the '/posts/{postId}' endpoint with the title in the body.
  /// Prints the updated post's response body or an error message if the request fails.
  Future<void> updatePost(int postId, String title) async {
    try {
      final response = await apiService.put(
        '/posts/$postId',
        body: {'title': title},
      );
      print('Updated Post: ${response.body}');
    } catch (e) {
      print('Error updating post: $e');
    }
  }
}
