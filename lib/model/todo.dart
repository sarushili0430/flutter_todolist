import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo implements _$Todo {
  const Todo._();
  factory Todo({
    int? id,
    required String title,
    required bool status,
  }) = _Todo;

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      status: map['status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'status': status == true ? 1 : 0};
  }
}
