import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_provider.dart';

final incompleteTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);

  return todos.where((todo) => !todo.done).toList();
});