import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/views.dart';

void main() {
  // 最初に表示するWidget
  runApp(ProviderScope(child: MyTodoApp()));
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
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => TodoListPage(
              title: title,
            ),
        '/todo_add': (BuildContext context) => TodoAddPage()
      },
    );
  }
}
