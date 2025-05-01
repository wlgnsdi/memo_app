import 'package:memo_app/data/models/memo_entity.dart';
import 'package:memo_app/models/memo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'memos.db';
  static const int _version = 1;

  static const String _tableMemos = 'memos';

  static Database? _database;

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableMemos (
        ${MemoEntity.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MemoEntity.columnContent} TEXT NOT NULL,
        ${MemoEntity.columnCreatedAt} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertMemo(Memo memo) async {
    final db = await database;
    MemoEntity memoEntity = MemoEntity(
      content: memo.content,
      createdAt: memo.createdAt.toIso8601String(),
    );

    return await db.insert(_tableMemos, memoEntity.toMap());
  }

  Future<List<Memo>> getMemos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableMemos);
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i][MemoEntity.columnId],
        content: maps[i][MemoEntity.columnContent],
        createdAt: DateTime.parse(maps[i][MemoEntity.columnCreatedAt]),
      );
    });
  }

  Future<int> updateMemo(Memo memo) async {
    final db = await database;
    MemoEntity memoEntity = MemoEntity(
      id: memo.id,
      content: memo.content,
      createdAt: memo.createdAt.toIso8601String(),
    );

    return await db.update(
      _tableMemos,
      memoEntity.toMap(),
      where: '${MemoEntity.columnId} = ?',
      whereArgs: [memo.id],
    );
  }

  Future<int> deleteMemo(int id) async {
    final db = await database;
    return await db.delete(
      _tableMemos,
      where: '${MemoEntity.columnId} =?',
      whereArgs: [id],
    );
  }

  // Future<List<Memo>> searchMemos(String keyword) async { ... }
}
