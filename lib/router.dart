import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'view/views.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/',
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const TodoListPage(title: "To-Do"),
        );
      },
    ),
    // ex) アカウント画面
    GoRoute(
      path: '/todo_add',
      name: 'todo_add',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const TodoAddPage(),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
