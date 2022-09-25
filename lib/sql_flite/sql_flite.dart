import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initialDbb();
      return _db!;
    } else {
      return _db!;
    }
  }

  initialDbb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "ali.db");
    Database database = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return database;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    debugPrint("onUpgrade=========================");
   // await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  _onCreate(Database db, int version) async {
    Batch batch=db.batch();

     batch.execute('''
   CREATE TABLE "notes"(
   "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   "note" TEXT NOT NULL,
   "title" TEXT NOT NULL,
   "color" TEXT NOT NULL
   )
  ''');

     await batch.commit();
    debugPrint("Create DataBase and table=============");
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb.rawUpdate(sql);
    return response;
  }
  myDeleteDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "ali.db");
    await deleteDatabase(path);
  }



  //=====================
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb.query(table);
    return response;
  }

  insert(String table,Map<String,Object> value) async {
    Database? myDb = await db;
    int response = await myDb.insert(table,value);
    return response;
  }

  delete(String table,String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb.delete(table,where: myWhere);
    return response;
  }

  update(String table,Map<String,Object> value,String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb.update(table,value,where: myWhere);
    return response;
  }

}
