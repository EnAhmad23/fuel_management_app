import 'dart:developer';

import 'package:fuel_management_app/Model/operation.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBModel {
  static Database? _db;
  Future<Database?> get db async {
    _db ??= await intiDataBase();
    return _db;
  }

  intiDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'fuel_managment.db');
    Database myDB = await openDatabase(path, onCreate: _onCreate, version: 1);
    return myDB;
  }

  delDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'fuel_managment.db');
    await deleteDatabase(path);
  }

  _onCreate(Database database, int version) async {
    await database.execute('''
  CREATE TABLE consumers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sub_consumers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    consumer_id INTEGER NOT NULL,
    details TEXT,
    description TEXT,
    hasRecord INTEGER DEFAULT 0,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (consumer_id) REFERENCES consumers(id)
);

CREATE TABLE movement_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sub_consumer_id INTEGER NOT NULL,
    record TEXT,
    date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sub_consumer_id) REFERENCES sub_consumers(id)
);


CREATE TABLE operations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sub_consumer_id INTEGER ,
    amount DECIMAL(8, 2),
    description TEXT,
    type TEXT CHECK(type IN ('صرف', 'وارد')),
    foulType TEXT CHECK(foulType IN ('بنزين', 'سولار')),
    receiverName TEXT,
    dischangeNumber TEXT,
    date DATE,
    checked INTEGER DEFAULT 0,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sub_consumer_id) REFERENCES sub_consumers(id)
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    remember_token TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 ''');
    log('create database');
  }

  Future<List<Map<String, Object?>>> getLastTenOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.query(
      'operations',
      limit: 10,
      orderBy: 'date DESC',
    );
    return re;
  }

  Future<List<Map<String, Object?>>> getAllOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.query(
      'operations',
    );
    return re;
  }

  Future<List<Map<String, Object?>>> getOp(int opId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
      select * from operations where id = ?
    ''', [opId]);
    return re;
  }

  getNumOfOp(int subconsumerId) async {
    Database? database = await db;
    List<Map<String, dynamic>> re =
        await database!.rawQuery('''SELECT COUNT(*) AS operation_count
    FROM operations
    WHERE sub_consumer_id = ?
      AND type = 'صرف';
''', [subconsumerId]);
    return Sqflite.firstIntValue(re) ?? 0;
  }

  Future<List<Map<String, Object?>>?> getSubconsumerForTable() async {
    Database? database = await db;
    List<Map<String, Object?>>? re = await database?.rawQuery("""
      SELECT 
    c.name AS consumer_name,
    sc.details AS subconsumer_details,
    sc.description AS subconsumer_description,
    COUNT(o.id) AS number_of_operations
FROM 
    consumers c
JOIN 
    sub_consumers sc ON c.id = sc.consumer_id
LEFT JOIN 
    operations o ON sc.id = o.sub_consumer_id AND o.type = 'صرف'
GROUP BY 
    c.name, sc.details, sc.description;
 
    """);
    return re;
  }

  Future<List<Map<String, Object?>>> getConsumerForTable() async {
    Database? database = await db;
    List<Map<String, Object?>> result = await database!.rawQuery('''
    SELECT 
        c.id as consumer_id,
        c.name AS consumer_name,
        COUNT(DISTINCT sc.id) AS number_of_subconsumers,
        COUNT(DISTINCT o.id) AS number_of_operations
    FROM 
        consumers c
    LEFT JOIN 
        sub_consumers sc ON c.id = sc.consumer_id
    LEFT JOIN 
        operations o ON sc.id = o.sub_consumer_id
    GROUP BY 
        c.name;
  ''');
    return result;
  }

  Future<List<Map<String, Object?>>> getConsumersNames() async {
    Database? database = await db;
    List<Map<String, Object?>> re =
        await database!.rawQuery('''Select name form consumers ''');
    return re;
  }

  Future<int?> getConsumerID(String consumerName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select id form consumers  where name = ? ''', [consumerName]);
    return Sqflite.firstIntValue(re) ?? -1;
  }

  Future<int?> getSubonsumerID(String? SubconsumerName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select id form sub_consumers  where details = ? ''',
        [SubconsumerName]);
    return Sqflite.firstIntValue(re) ?? -1;
  }

  Future<int> addConsumer(String name) async {
    Database? database = await db;
    return await database!.rawInsert('''
    insert into consumers (name) values(?)
    ''', [name]);
  }

  Future<int?> addOperation(OperationT operation) async {
    Database? database = await db;
    return await database?.rawInsert('''
    INSERT INTO operations (
      sub_consumer_id, 
      amount, 
      description, 
      type, 
      foulType, 
      receiverName, 
      dischangeNumber, 
      date, 
      checked, 
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, )
  ''', [
      // Assuming subConsumerDetails can be mapped to sub_consumer_id
      getSubonsumerID(operation.subConsumerDetails),
      operation.amount,
      operation.description,
      operation.type,
      operation.foulType,
      operation.receiverName,
      operation.dischangeNumber,
      operation.newDate!.toIso8601String(),
      operation.checked! ? 1 : 0,
    ]);
  }

  // Future<int> addOper(OperationT operationT) async {
  //   Database? database = await db;
  //   return await database!.rawInsert('''
  //   insert into operations (name) values(?)
  //   ''', [name]);
  // }

  Future<int> addSubonsumer(String name, String description,
      String consumerName, int hasRecord) async {
    Database? database = await db;
    int? consumerID = await getConsumerID(consumerName);
    return await database!.rawInsert('''
    insert into sub_consumers (details,description,consumer_id,hasRecord) values(?,?,?,?)
    ''', [name, description, consumerID, hasRecord]);
  }

  Future<List<Map<String, Object?>>> searchOp(Operation operation) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''sql''');
    return re;
  }
}
