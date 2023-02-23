import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoasync/models/Todo.dart';
import 'package:todoasync/network/network_request.dart';

final allTodos = [];

final todoStateFuture = FutureProvider<List<Todo>>((ref) async {
  return fetchTodos();
});
