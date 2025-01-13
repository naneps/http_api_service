
---

# api_service

`api_service` is a Dart package that provides an easy-to-use, reusable HTTP service for Flutter applications. With this package, you can perform various HTTP requests such as GET, POST, PUT, and DELETE in a simple and structured way.

## Key Features

- **Supports multiple HTTP methods**: GET, POST, PUT, DELETE
- **Robust Response Handling**: Easily manage responses and exceptions
- **Reusable and Easy to Use**: Can be reused across different parts of the application
- **Logging**: Logs each request and response for easier debugging
- **Supports query parameters and custom headers**: Customize each request to fit your application's needs

## Installation

To use this package, add `api_service` to your `pubspec.yaml` file from **pub.dev**:

```yaml
dependencies:
  api_service: ^1.0.0
```

Then run the following command to install the dependencies:

```bash
dart pub get
```

Alternatively, if you want to use the latest version directly from GitHub, you can add it like this:

```yaml
dependencies:
  api_service:
    git:
      url: https://github.com/naneps/api_service.git
      ref: main
```

Then run:

```bash
dart pub get
```

## Usage

### Initialize ApiService

To use `ApiService`, you need to initialize an instance of the `ApiService` class with the base URL of the API you want to interact with.

```dart
import 'package:api_service/api_service.dart';

void main() {
  final apiService = ApiService(baseUrl: 'https://api.example.com');
}
```

### Using HTTP Methods

Here’s how to use the different HTTP methods supported by `api_service`:

#### GET Request

```dart
final response = await apiService.get('/users');
if (response.statusCode == 200) {
  // Successful response
  print('Response: ${response.body}');
} else {
  // Handle error
  print('Error: ${response.statusCode}');
}
```

#### POST Request

```dart
final response = await apiService.post(
  '/users',
  body: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
);
if (response.statusCode == 201) {
  // Data successfully created
  print('Created: ${response.body}');
} else {
  // Handle error
  print('Error: ${response.statusCode}');
}
```

#### PUT Request

```dart
final response = await apiService.put(
  '/users/1',
  body: {
    'name': 'John Doe Updated',
    'email': 'john_updated@example.com',
  },
);
if (response.statusCode == 200) {
  // Data successfully updated
  print('Updated: ${response.body}');
} else {
  // Handle error
  print('Error: ${response.statusCode}');
}
```

#### DELETE Request

```dart
final response = await apiService.delete('/users/1');
if (response.statusCode == 200) {
  // Data successfully deleted
  print('Deleted: ${response.body}');
} else {
  // Handle error
  print('Error: ${response.statusCode}');
}
```

## Error Handling

`api_service` automatically handles common HTTP status codes and throws exceptions based on the error type.

Example error handling:

```dart
try {
  final response = await apiService.get('/users');
  // Handle successful response
} catch (e) {
  print('Error occurred: $e');
}
```

### Handled Exceptions:
- `BadRequestException`
- `UnauthorizedException`
- `ForbiddenException`
- `NotFoundException`
- `InternalServerErrorException`
- `ApiException`

## Contribution

If you want to contribute to this project, feel free to fork this repository and submit a pull request. Before doing so, make sure to follow the code guidelines and run tests.

## License

This package is licensed under the [MIT License](LICENSE).

---

For further questions or support, visit the [GitHub repository](https://github.com/naneps/api_service).

---

