import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewTodo extends ConsumerWidget {
  static const routeName = '/new-todo';
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _submitEntry() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new TODO',
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                controller: descriptionController,
                keyboardType: TextInputType.number,
                onSubmitted: (value) => _submitEntry(),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () => _submitEntry(),
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
