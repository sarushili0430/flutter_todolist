import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo.dart';
import '../repository/todo_repository.dart';

part 'todo_view_model.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() {
    final state = ref.watch(todoRepositoryProvider);
    return state.value ?? [];
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
