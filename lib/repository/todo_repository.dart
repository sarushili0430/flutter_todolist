import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/todo.dart';
import 'package:riverpod/riverpod.dart';

part 'todo_repository.g.dart';

@Riverpod(keepAlive: true)
class TodoRepository extends _$TodoRepository {
  late Database _db;

  @override
  FutureOr<List<Todo>> build() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/app_database.db';

    _db = await _initDatabase();
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
    return await _db.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final result = await _db.query('todos');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> updateTodo(int id, bool status) async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/app_database.db';
    return await _db.update(
      'todos',
      {"status": status == false ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(int id) async {
    return await _db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    await _db.close();
  }
}
