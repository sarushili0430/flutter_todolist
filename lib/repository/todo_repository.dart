import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/todo.dart';
import 'package:riverpod/riverpod.dart';

part 'todo_repository.g.dart';

@Riverpod(keepAlive: true)
class TodoRepository extends _$TodoRepository {
  late Database db;

  @override
  FutureOr<List<Todo>> build() async {
    db = await _initDatabase();
    return getAllTodos();
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/app_database.db';

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          status BOOL NOT NULL)''');
      },
    );
  }

  Future<int> insertTodo(Todo todo) async {
    return await db.insert('items', todo.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final result = await db.query('todos');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> deleteItem(int id) async {
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    await db.close();
  }
}
