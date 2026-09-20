import 'package:flutter_test/flutter_test.dart';
import 'package:week4_api/data/models/comment.dart';

void main() {
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
}