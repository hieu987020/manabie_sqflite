# A Flutter project: todo app. 
State management: Bloc pattern </br>
Database: SQflite

Example
### Example
[<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/create.gif?raw=true" width="200"/>]()
[<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/todo.gif?raw=true" width="200"/>]()
### SQflite database

```dart
import 'package:manabie_todoapp/data/data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodosDatabase {
  static final TodosDatabase instance = TodosDatabase._init();

  static Database? _database;

  TodosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    TodosDatabase.instance.deleteAll();
    await TodosDatabase.instance.create(Todo(
      name: 'TodoA',
      detail: 'Listen to music',
      date: DateTime.now().toIso8601String(),
    ));
    await TodosDatabase.instance.create(Todo(
      name: 'TodoB',
      detail: 'Clean house',
      date: DateTime.now().toIso8601String(),
    ));
    await TodosDatabase.instance.create(Todo(
      name: 'TodoC',
      detail: 'Go to school early',
      date: DateTime.now().toIso8601String(),
    ));
    await TodosDatabase.instance.create(Todo(
        name: 'TodoD',
        detail: 'Eat breakfast with friend at big C',
        date: DateTime.now().toIso8601String(),
        status: 'Complete'));
    await TodosDatabase.instance.create(Todo(
        name: 'TodoE',
        detail: 'Sleep 100000 seconds',
        date: DateTime.now().toIso8601String(),
        status: 'Complete'));
    await TodosDatabase.instance.create(Todo(
        name: 'TodoF',
        detail: 'playing game',
        date: DateTime.now().toIso8601String(),
        status: 'Complete'));
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    // final boolType = 'BOOLEAN NOT NULL';
    // final integerType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE $tableTodos ( 
  ${TodoFields.id} $idType, 
  ${TodoFields.name} $textType,
  ${TodoFields.detail} $textType,
  ${TodoFields.status} $textType,
  ${TodoFields.date} $textType
  )
''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodos, todo.toMap());
    return Todo(
      id: id,
      name: todo.name,
      detail: todo.detail,
      status: todo.status,
      date: todo.date,
    );
  }

  Future<Todo> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Todo>> readAll(String status) async {
    final db = await instance.database;
    if (status.isEmpty) {
      final orderBy = '${TodoFields.date} DESC';
      final result = await db.rawQuery(
        'SELECT * FROM $tableTodos ORDER BY $orderBy',
      );
      return result.map((json) => Todo.fromMap(json)).toList();
    } else {
      final orderBy = '${TodoFields.date} DESC';
      final result = await db.rawQuery(
          'SELECT * FROM $tableTodos WHERE ${TodoFields.status} =? ORDER BY $orderBy',
          ['$status']);
      return result.map((json) => Todo.fromMap(json)).toList();
    }
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodos,
      todo.toMap(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    // final result = await db.rawQuery(
    //   'DELETE FROM $tableTodos',
    // );
    return db.delete(tableTodos);
  }
  // Future<int> delete(int id) async {
  //   final db = await instance.database;

  //   return await db.delete(
  //     tableNotes,
  //     where: '${NoteFields.id} = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
```
### Development
```
[√] Flutter (Channel stable, 2.5.3, on Microsoft Windows [Version 10.0.19043.1348], locale en-US)
[√] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[√] Chrome - develop for the web
[√] Android Studio (version 4.2)
[√] VS Code (version 1.63.0)
[√] Connected device (3 available)
```
