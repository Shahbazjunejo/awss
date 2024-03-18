import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "SindhSupportUnit";
  static final _databaseVersion = 1;

  static final table = 'login_table';
  static final columnId = 'id';
  static final columnName = 'username';
  static final columnPassword = 'password';



  static final tablestudent = 'students';
  static final columnIdstudent = 'id';
  static final columnNamestudent = 'name';
  static final columnAge = 'age';
  static final columnGrade = 'grade';
  static final columnAddress = 'address';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablestudent (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT ,
        $columnAge INTEGER ,
        $columnGrade TEXT  ,
        $columnAddress TEXT 
      )
    ''');
  }
  Future<int> insertStudent(String name, int age, String grade, String address) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      columnName: name,
      columnAge: age,
      columnGrade: grade,
      columnAddress: address,
    };
    return await db?.insert(tablestudent, row)??0;
  }
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row)??0;
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db?.query(table,
        where: '$columnName = ?', whereArgs: [username])??[];
    return result.isNotEmpty ? result.first : null;
  }
}
