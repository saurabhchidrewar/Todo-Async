import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/Todo.dart';

List<Todo> parseTodos(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<Todo> todos = list.map((model) => Todo.fromJson(model)).toList();
  return todos;
}

Future<List<Todo>> fetchTodos() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return compute(parseTodos, response.body);
  } else {
    throw Exception('Did not find TODOs');
  }
}
