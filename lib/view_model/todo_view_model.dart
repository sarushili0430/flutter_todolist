import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo.dart';
import '../repository/todo_repository.dart';

part 'todo_view_model.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() {
    final state = ref.watch(todoRepositoryProvider);
    log("state.value: ${state.value}");
    return state.value ?? [];
  }

  void addTodo(String title) {
    log("title: $title");

    // 一時的な Todo を作成（仮の ID を使用する）
    final tempTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch, title: title, status: false);

    // キャッシュを即時更新
    state = [...state, tempTodo];
    log("State after temporary update: $state");

    // データベースの更新（非同期）
    ref.read(todoRepositoryProvider.notifier).insertTodo(tempTodo).then((id) {
      // 成功時: ID を更新
      state = state.map((todo) {
        return todo == tempTodo
            ? Todo(id: id, title: todo.title, status: todo.status)
            : todo;
      }).toList();
      log("State after database sync: $state");
    }).catchError((error) {
      // エラー時: 仮の Todo を削除
      state = state.where((todo) => todo != tempTodo).toList();
      log("Error updating database, state reverted: $state");
    });
  }

  void updateTodo(int id) {
    try {
      final newStateIndex = state.indexWhere((item) => item.id == id);
      final newState =
          state[newStateIndex].copyWith(status: !state[newStateIndex].status);
      final newList = List<Todo>.from(state)..[newStateIndex] = newState;
      state = newList;

      log("$state");

      ref
          .read(todoRepositoryProvider.notifier)
          .updateTodo(newState.id!, newState.status);
    } catch (e) {
      log("エラー:$e");
    }
  }

  void deleteTodo(int id) {
    try {
      final newList = List<Todo>.from(state);
      newList.removeWhere((todo) => todo.id == id);
      state = newList;
      log("deleteTOdo: $state");
      ref.read(todoRepositoryProvider.notifier).deleteTodo(id);
    } catch (e) {
      log("エラー");
    }
  }
}
