import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo.dart';

part 'todo_view_model.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() {
    return [
      Todo(id: 1, title: "aaaaa", status: false),
      Todo(id: 1, title: "bbbbbbbb", status: false),
      Todo(id: 1, title: "bbbbccccc", status: false),
      Todo(id: 1, title: "bbbbbbbb", status: false),
      Todo(id: 1, title: "bbbbccccc", status: false)
    ];
  }

  void addTodo(String title) {
    state = [...state, Todo(id: 1, title: title, status: false)];
  }

  void updateTodo(int index) {
    final newState = state[index].copyWith(status: !state[index].status);
    final newList = List<Todo>.from(state)..[index] = newState;
    state = newList;
  }

  void deleteTodo(Todo todo) {
    final newList = List<Todo>.from(state);
    newList.remove(todo);
    state = newList;
  }
}
