import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week4_api/data/models/post.dart';
import 'package:week4_api/data/providers.dart';
import 'package:week4_api/data/repositories/post_repository.dart';
import 'package:week4_api/pages/post_list_page.dart';

class FakePostRepository extends PostRepository {
  FakePostRepository()
      : super(Dio());

  @override
  Future<List<Post>> fetchPosts() async {
    return [
      const Post(
        userId: 1,
        id: 1,
        title: 'Test Post',
        body: 'Test body',
      ),
    ];
  }
}

void main() {
  testWidgets('PostListPage displays posts', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postRepositoryProvider.overrideWithValue(
            FakePostRepository(),
          ),
        ],
        child: const MaterialApp(
          home: PostListPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Test Post'), findsOneWidget);
    expect(find.text('Test body'), findsOneWidget);
  });
}