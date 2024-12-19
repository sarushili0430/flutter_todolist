import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/views.dart';

void main() {
  // 最初に表示するWidget
  runApp(ProviderScope(child: MyTodoApp()));
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = "To-Do";
    return MaterialApp(
      // アプリ名
      title: title,
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(title: title),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => TodoListPage(
              title: title,
            ),
        '/todo_add': (BuildContext context) => TodoAddPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
