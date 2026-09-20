# AI Initial Output

The following is the initial AI-generated solution for the AI Challenge.

## 1. Comment Model

```dart
class Comment {
  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: (json['postId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}

##2 comment repo
import 'package:dio/dio.dart';
import '../models/comment.dart';

class CommentRepository {
  CommentRepository(this._dio);

  final Dio _dio;

  Future<List<Comment>> fetchComments(int postId) async {
    final response = await _dio.get<List>(
      '/comments',
      queryParameters: {'postId': postId},
    );

    final data = response.data ?? [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(Comment.fromJson)
        .toList();
  }
}

## 3.AsyncNotifierProvider
final commentRepositoryProvider = Provider<CommentRepository>(
  (ref) => CommentRepository(createDio()),
);

class CommentNotifier extends AsyncNotifier<List<Comment>> {
  @override
  Future<List<Comment>> build() async {
    return ref.watch(commentRepositoryProvider).fetchComments(1);
  }
}

final commentProvider =
    AsyncNotifierProvider<CommentNotifier, List<Comment>>(
  CommentNotifier.new,
);

4.user friendly eror handling
the ai generated a function to convert dio eror into ma=essages that easier to understand
String friendlyCommentErrorMessage(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Slow connection or timeout. Check your internet and retry.';

      case DioExceptionType.connectionError:
        return 'Cannot reach the server. Check your internet connection.';

      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;

        if (code == 404) {
          return 'Data not found (404).';
        }

        if (code == 500) {
          return 'Server problem (500). Try again later.';
        }

        return 'Server problem ($code). Try again later.';

      default:
        return 'A network error occurred. Try again.';
    }
  }

  return 'An unexpected error occurred: $error';
}
5.unit test
the ai generated a unit test to verify that comment.fromJson() safely handles missing fielsd
test('Comment.fromJson handles missing fields safely', () {
  final comment = Comment.fromJson({
    'postId': 1,
    'name': 'Wahyu',
  });

  expect(comment.postId, 1);
  expect(comment.id, 0);
  expect(comment.name, 'Wahyu');
  expect(comment.email, '');
  expect(comment.body, '');
});
6.initial result 
the generated implementaion was added to the flutter project and checked using flutter analyzed and unit test