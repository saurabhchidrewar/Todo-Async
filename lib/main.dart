// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todoasync/models/Todo.dart';
import 'package:todoasync/state/state_manager.dart';
import './screens/new_todo.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo - Async',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        NewTodo.routeName: (context) => NewTodo(),
      },
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Todo>> todos = ref.watch(todoStateFuture);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo - Async"),
      ),
      body: todos.when(
        data: (todos) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade200,
                      child: Text(
                        todos[index].id.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                          decoration: todos[index].completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    trailing: Checkbox(
                      value: todos[index].completed,
                      onChanged: (val) {
                        setState(() {
                          todos[index].completed = !todos[index].completed;
                        });
                      },
                    ),
                  ),
                ],
              );
            },
            itemCount: 15,
          );
        },
        error: ((err, stackTrace) => Center(
              child: Text(err.toString()),
            )),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewTodo.routeName);
        },
        elevation: 5,
        child: Icon(Icons.add),
      ),
    );
  }
}
