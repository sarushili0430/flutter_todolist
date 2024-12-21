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
    //settingsマークにpaddingを持たせる
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(onPressed: () => {}, icon: Icon(Icons.settings))
            ],
            bottom: TabBar(tabs: [
              Tab(text: "Todo"),
              Tab(text: "Done"),
            ])),
        body: TabBarView(
          children: [
            Center(
              child: TodoList(),
            ),
            Center(
              child: DoneList(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/todo_add');
            }),
      ),
    );
  }
}

class DoneList extends ConsumerWidget {
  const DoneList({super.key});

  //idを持たせて状態を管理する

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos = ref.watch(todoNotifierProvider);
    final List<Todo> finishedList = getFinishedList(todos);
    return ListView.builder(
        itemCount: finishedList.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            leading: IconButton(
                icon: Icon(finishedList[index].status
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () {
                  ref.read(todoNotifierProvider.notifier).updateTodo(index);
                  print(todos);
                }),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(todoNotifierProvider.notifier)
                    .deleteTodo(todos[index]);
              },
            ),
            title: Text(finishedList[index].title),
          ));
        });
  }
}

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos = ref.watch(todoNotifierProvider);
    final List<Todo> todoList = getTodoList(todos);
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            leading: IconButton(
              icon: Icon(todoList[index].status
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () {
                ref.read(todoNotifierProvider.notifier).updateTodo(index);
                print(todoList);
              },
            ),
            title: Text(todoList[index].title),
          ));
        });
  }
}

List<Todo> getTodoList(List<Todo> todoList) {
  List<Todo> currentTodoList = [];
  for (final task in todoList) {
    if (task.status == false) {
      currentTodoList.add(task);
    }
  }
  return currentTodoList;
}

List<Todo> getFinishedList(List<Todo> todoList) {
  List<Todo> finishedList = [];
  for (final task in todoList) {
    if (task.status == true) {
      finishedList.add(task);
    }
  }
  return finishedList;
}
