import 'package:http_api_service/http_api_service.dart';

/// A wrapper class for demonstrating advanced ApiService usage
class ExampleService {
  final ApiService apiService;

  ExampleService(String baseUrl) : apiService = ApiService(baseUrl: baseUrl);

  Future<void> fetchPosts() async {
    try {
      final response = await apiService.get('/posts');
      print('Fetched Posts: ${response.body}');
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}

///extendable example
class PostService extends ExampleService {
  PostService() : super("https://jsonplaceholder.typicode.com");

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

  Future<void> deletePost(int postId) async {
    try {
      final response = await apiService.delete(
        '/posts/$postId',
      );
      print('Deleted Post: ${response.body}');
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  Future<Response> fetchPost(int postId) async {
    try {
      final response = await apiService.get(
        '/posts/$postId',
      );
      return response;
    } catch (e) {
      throw Exception('Error fetching post: $e');
    }
  }

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
