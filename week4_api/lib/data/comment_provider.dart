import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';
import 'models/comment.dart';
import 'repositories/comment_repository.dart';

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