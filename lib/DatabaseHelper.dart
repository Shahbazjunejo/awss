import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sindhsupportunit/widgets/SyncDataScreen.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "SindhSupportUnitprogram";
  static final _databaseVersion = 5;

  static final table = 'login_table';
  static final columnId = 'id';
  static final columnName = 'username';
  static final schoolName = 'schoolname';
  static final columnPassword = 'password';
  static final columnaccessToken = 'access_token';
  static final columnemail = 'Email';
  static final columnsync = 'sync';
  static final columncontact = 'Contact';
  static final columncnic = 'Cnic';
  static final columnfatherName='fathername';
  static final columnfathercnic='fathercnic';

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
        $columncontact TEXt ,
        $columnfatherName TEXT  ,
        $columnfathercnic TEXT,
        $columnemail TEXT,
        $columnsync TEXT
         
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


  Future<int> insertStudent(String name, String contact, String fathername, String fathercnic,String email) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      columnName: name,
      columncontact: contact,
      columnfatherName: fathername,
      columnfathercnic: fathercnic,
      columnemail: email
    };
    return await db?.insert(tablestudent, row)??0;
  }

  Future<List<StudentData>> getItems() async {
    final Database? db = await database;
    final List<Map<String, dynamic>>? maps = await db?.query('students');
    return List.generate(maps!.length, (i) {
      return  StudentData(
      //  id: maps[i]['id'],
        name: maps[i]['username'] ?? '', // Provide default value if null
        contact: maps[i]['Contact'] ?? '', // Provide default value if null
        fathername: maps[i]['fathername'] ?? '', // Provide default value if null
        fatherCNIC: maps[i]['fathercnic'] ?? '', // Provide default value if null
        email: maps[i]['Email'] ?? '',
      );
    });
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
