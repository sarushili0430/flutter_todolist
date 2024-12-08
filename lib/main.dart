import 'dart:ffi';

import 'package:flutter/material.dart';
import 'models/todo.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = "My Todo App";
    return MaterialApp(
      // アプリ名
      title: title,
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(title: title),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key, required this.title}) : super(key: key);
  final ValueNotifier<List<Todo>> _todos = ValueNotifier<List<Todo>>([]);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: _todos,
            builder: (context, value, child) {
              return TodoList(todos: _todos);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTodo = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return TodoAddPage();
          }));
          if (newTodo != "" && newTodo != null) {
            _todos.value = [
              ..._todos.value,
              Todo(title: newTodo, status: false),
            ];
          }
        },
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key? key, required this.todos}) : super(key: key);
  final ValueNotifier<List<Todo>> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> testData = [
    Todo(title: "aaaaa", status: false),
    Todo(title: "bbbbbbbb", status: false),
    Todo(title: "bbbbccccc", status: false),
    Todo(title: "bbbbbbbb", status: false),
    Todo(title: "bbbbccccc", status: false)
  ];

  @override
  Widget build(BuildContext context) {
    //条件 ? 式1 : 式2;
    return ListView.builder(
      itemCount: widget.todos.value.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
                leading: ValueListenableBuilder(
                    valueListenable: widget.todos,
                    builder: (context, value, child) {
                      return IconButton(
                        icon: Icon(widget.todos.value[index].status
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        onPressed: () {
                          widget.todos.value = List.from(widget.todos.value)
                            ..[index] = widget.todos.value[index].copyWith(
                                status: !widget.todos.value[index].status);
                          print(widget.todos.value);
                        },
                      );
                    }),
                title: Text(widget.todos.value[index].title)));
      },
    );
  }
}

class TodoAddPage extends StatelessWidget {
  const TodoAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInput(),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("キャンセル"))
      ],
    )));
  }
}

class TextInput extends StatefulWidget {
  const TextInput({super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final ValueNotifier<String> _text = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            TextField(
              onChanged: (String value) {
                _text.value = value;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).pop(_text.value);
              },
              child: Text('リスト追加'),
            ),
          ],
        ));
  }
}
