import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "SindhSupportUnitprogram";
  static final _databaseVersion = 3;

  static final table = 'login_table';
  static final columnId = 'id';
  static final columnName = 'username';
  static final schoolName = 'schoolname';
  static final columnPassword = 'password';
  static final columnaccessToken = 'access_token';
  static final columnemail = 'Email';
  static final columncontact = 'Contact';
  static final columncnic = 'Cnic';


  static final tablestudent = 'students';
  static final tableinformationdata = 'informationData';
  static final columnIdstudent = 'id';
  static final columnNamestudent = 'name';
  static final columnAge = 'age';
  static final columnGrade = 'grade';
  static final columnAddress = 'address';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database=null;

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
      CREATE TABLE  IF NOT EXISTS $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL,
        $columnaccessToken TEXT 
      )
    ''');

    await db.execute('''
      CREATE TABLE  IF NOT EXISTS $tablestudent (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT ,
        $columnAge INTEGER ,
        $columnGrade TEXT  ,
        $columnAddress TEXT 
      )
    ''');


    await db.execute('''
      CREATE TABLE  IF NOT EXISTS $tableinformationdata (
        $columnId INTEGER PRIMARY KEY,
        $schoolName TEXT,
        $columnName TEXT,
        $columnemail TEXT,
        $columncontact TEXT,
        $columncnic TEXT,
        $columnAddress TEXT,
        $columnaccessToken TEXT
      )
    ''');



/*    await db.execute('''
      CREATE TABLE $tableinformationdata (
        $columnId INTEGER PRIMARY KEY,
        $schoolName TEXT,
        $columnName TEXT,
        $columnemail TEXT,
        $columncontact TEXT,
        $columncnic TEXT,
        $columnAddress TEXT,
        $columnaccessToken TEXT,
      )
    ''');*/
/*    await db.execute('''
      CREATE TABLE $tableinformationdata( $columnId INTEGER PRIMARY KEY,   $Name TEXT,   $columnName TEXT, $columnemail TEXT, "
            "$columncontact TEXT, $columncnic TEXT,$columnAddress TEXT,$columnaccessToken TEXT, "
      )
    ''');*/




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

  Future<int> insertSchoolData(String? name,String? username,String? email, String?  contact, String? cnic, String? address,String? accessToken) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      schoolName: name,
      columnName: username,
      columnemail: email,
      columncontact: contact,
      columncnic: cnic,
      columnAddress: address,
      columnaccessToken:accessToken
    };
    return await db?.insert(tableinformationdata, row)??0;
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

  Future<Map<String, dynamic>?> getInformationData(String username) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db?.query(tableinformationdata,
        where: '$columnemail = ?', whereArgs: [username])??[];
    return result.isNotEmpty ? result.first : null;
  }


}
