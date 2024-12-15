import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/todo.dart';
import '../view_model/view_models.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Riverpod 2.0からProviderは自動生成されるようになった
    final List<Todo> _todos = ref.watch(todoNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: TodoList(),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final newTodo = await Navigator.of(context).pushNamed('/todo_add');
          }),
    );
  }
}

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos = ref.watch(todoNotifierProvider);
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            leading: IconButton(
              icon: Icon(todos[index].status
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () {
                ref.read(todoNotifierProvider.notifier).updateTodo(index);
                print(todos);
              },
            ),
            title: Text(todos[index].title),
          ));
        });
  }
}
