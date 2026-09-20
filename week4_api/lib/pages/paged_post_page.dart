import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/paged_posts.dart';
import '../data/network_errors.dart';
import 'post_tile.dart';

class PagedPostPage extends ConsumerStatefulWidget {
  const PagedPostPage({super.key});

  @override
  ConsumerState<PagedPostPage> createState() => _PagedPostPageState();
}

class _PagedPostPageState extends ConsumerState<PagedPostPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(pagedPostsProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pagedPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Pagination'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(PagedPostsState state) {
    if (state.items.isEmpty && state.isLoadingMore) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.items.isEmpty && state.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                friendlyErrorMessage(state.error!),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  ref
                      .read(pagedPostsProvider.notifier)
                      .loadFirstPage();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: state.items.length + 1,
      itemBuilder: (context, index) {
        if (index == state.items.length) {
          if (state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!state.hasMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text('All data loaded.'),
              ),
            );
          }

          return const SizedBox.shrink();
        }

        final post = state.items[index];

        return PostTile(post: post);
      },
    );
  }
}