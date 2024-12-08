import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String title,
    required bool status,
  }) = _Todo;
}
