import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intelligentassistant/tasks/presentation/provider/todos_provider.dart';

import '../../domain/todo.dart';

final pendingCounterProvider = Provider<int>((ref) {
  final List<Todo> todos = ref.watch<List<Todo>>(todosProvider);
  final pending = todos.where((todo) => todo.completed).toList();
  return pending.length;
});

final completedCounterProvider = Provider<int>((ref) {
  final List<Todo> todos = ref.watch<List<Todo>>(todosProvider);
  final completed = todos.where((todo) => todo.completed).toList();
  return completed.length;
});


final remindersCounterProvider = Provider<int>((ref) {
  return 0;
});
