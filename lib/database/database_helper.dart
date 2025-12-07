import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();


  static Database? _db;


  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }


  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'midterm.db');


    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
CREATE TABLE users (
id INTEGER PRIMARY KEY AUTOINCREMENT,
email TEXT UNIQUE,
password TEXT,
name TEXT
)
''');
        });
  }


// CRUD operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final dbClient = await db;
    return await dbClient.insert('users', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final dbClient = await db;
    final res = await dbClient.query('users', where: 'email = ?', whereArgs: [email]);
    if (res.isNotEmpty) return res.first;
    return null;
  }


  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final dbClient = await db;
    return await dbClient.query('users');
  }


  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final dbClient = await db;
    return await dbClient
        .update('users', user, where: 'id = ?', whereArgs: [id]);
  }


  Future<int> deleteUser(int id) async {
    final dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}