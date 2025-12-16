import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper{
  static final DataBaseHelper instance = DataBaseHelper._init();
  static Database? _database;

  DataBaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bunoti.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notifications (
        id TEXT NOT NULL,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        time TEXT NOT NULL,
        type TEXT NOT NULL,
        PRIMARY KEY(id)
      )
    ''');
  }

  // Insertar una notificacion
  Future<int> insertNotificaction(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('notifications', row);
  }

  // Obtener las notificaiones
  Future<List<Map<String, dynamic>>> getNotificaction() async {
    final db = await instance.database;
    return await db.query(
      'notifications',
      orderBy: 'id DESC',
    );
  }

  //Eliminar Notificacion
  Future<int> deleteNotificaction(String id) async {
    final db = await instance.database;
    return await db.delete(
      'notifications',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}