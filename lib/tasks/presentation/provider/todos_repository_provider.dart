import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/isar_repository.dart';
import '../../data/todos_repository.dart';

/// Provides an [IsarRepository] instance for managing local database operations.
final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  return IsarRepository();
});
