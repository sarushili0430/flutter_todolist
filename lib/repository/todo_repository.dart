import 'package:sqflite/sqflite.dart';
import 'package:todo/model/todo.dart';

class TodoRepository {
  static final TodoRepository _instance = TodoRepository._internal();
  Database? _database;

  TodoRepository._internal();

  factory TodoRepository() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
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
    final db = await database;
    return await db.insert('items', todo.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final result = await db.query('todos');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
