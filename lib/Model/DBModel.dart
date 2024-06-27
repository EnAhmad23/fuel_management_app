import 'dart:developer';

import 'package:fuel_management_app/Model/operation.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/Model/user.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'subconsumer.dart';

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
    is_deleted INTEGER DEFAULT 0,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sub_consumers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    consumer_id INTEGER NOT NULL,
    details TEXT,
    is_deleted INTEGER DEFAULT 0,
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
    is_deleted INTEGER DEFAULT 0,
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
    is_deleted INTEGER DEFAULT 0,
    remember_token TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 ''');
    log('create database');
  }

  Future<List<Map<String, Object?>>> checkUser(User user) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select id from users where username=? and password = ? and is_deleted=0
     ''', [user.username, user.password]);
    log('${re.length}');
    return re;
  }

  Future<int> addUser(String name, String password) async {
    Database? database = await db;
    int re = await database!
        .rawInsert('''insert into users (username,password) values (?,?)
     ''', [name, password]);
    return re;
  }

  Future<List<Map<String, Object?>>> getLastTenOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.query('operations',
        limit: 10, orderBy: 'date DESC', where: 'is_deleted=0');
    return re;
  }

  Future<List<Map<String, Object?>>> getAllOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re =
        await database!.query('operations', where: 'is_deleted=0');
    return re;
  }

  Future<List<Map<String, Object?>>> getOp(int opId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
      select * from operations where id = ? and is_deleted=0
    ''', [opId]);
    return re;
  }

  getNumOfOp(int subconsumerId) async {
    Database? database = await db;
    List<Map<String, dynamic>> re =
        await database!.rawQuery('''SELECT COUNT(*) AS operation_count
    FROM operations
    WHERE sub_consumer_id = ?
      AND type = 'صرف' and is_deleted=0;
''', [subconsumerId]);
    return Sqflite.firstIntValue(re) ?? 0;
  }

  Future<List<Map<String, Object?>>> getSubconsumerForTable() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery("""
   SELECT 
    sc.id,
    c.name AS consumerName,
    sc.details,
    sc.description,
    COUNT(o.id) AS numberOfOperations
FROM 
    sub_consumers sc
JOIN 
    consumers c ON sc.consumer_id = c.id
LEFT JOIN 
    operations o ON sc.id = o.sub_consumer_id
GROUP BY 
    sc.id, c.name, sc.details, sc.description
ORDER BY 
    sc.id;
where  is_deleted=0

    """);
    log('${re.length}');
    log('${re}');
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
        where is_deleted=0
  ''');
    return result;
  }

  Future<List<Map<String, Object?>>> getConsumersNames() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!
        .rawQuery('SELECT name FROM consumers where is_deleted=0');
    return re;
  }

  Future<int?> getConsumerID(String consumerName) async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery(
      '''SELECT id
       FROM consumers
       WHERE name = ?and is_deleted=0;
    ''',
      [consumerName],
    );
    return re.isNotEmpty ? re.first['id'] as int? : null;
  }

  Future<int?> getSubonsumerID(String? SubconsumerName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select id from sub_consumers  where details = ? and is_deleted=0''',
        [SubconsumerName]);
    return Sqflite.firstIntValue(re) ?? -1;
  }

  Future<int?> getNumOfConsumers() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select COUNT(DISTINCT id) from consumers  where  is_deleted=0''');
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

    // Await the Future to get the actual sub_consumer_id
    int? subConsumerId = await getSubonsumerID(operation.subConsumerDetails);

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
      checked
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''', [
      subConsumerId,
      operation.amount,
      operation.description,
      operation.type,
      operation.foulType,
      operation.receiverName,
      operation.dischangeNumber,
      DateFormat('yyyy-MM-dd')
          .format(operation.newDate!), // Format the date correctly
      operation.checked ?? false ? 1 : 0,
    ]);
  }

  Future<int?> addOperationWard(OperationT operation) async {
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
      checked
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''', [
      null,
      operation.amount,
      operation.description,
      operation.type,
      operation.foulType,
      operation.receiverName,
      operation.dischangeNumber,
      DateFormat('yyyy-MM-dd')
          .format(operation.newDate!), // Format the date correctly
      operation.checked ?? false ? 1 : 0,
    ]);
  }
  // Future<int> addOper(OperationT operationT) async {
  //   Database? database = await db;
  //   return await database!.rawInsert('''
  //   insert into operations (name) values(?)
  //   ''', [name]);
  // }

  Future<int> addSubonsumer(SubConsumer subconsumer) async {
    Database? database = await db;
    int? consumerID = await getConsumerID(subconsumer.consumerName);
    log('consumerName ${subconsumer.consumerName}');
    log('$consumerID');

    return await database!.rawInsert('''
    insert into sub_consumers (details,description,consumer_id,hasRecord) values(?,?,?,?)
    ''', [
      subconsumer.details,
      subconsumer.description,
      consumerID,
      subconsumer.hasRcord! ? 1 : 0
    ]);
  }

  Future<List<Map<String, Object?>>> searchOp(Operation operation) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''sql''');
    return re;
  }

  Future<int> deleteConsumer(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''UPDATE consumers
SET is_deleted = 1
WHERE id = ?;
''', [id]);
  }

  Future<int> deleteSubconsumer(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''UPDATE sub_consumers
SET is_deleted = 1
WHERE id = ?;
''', [id]);
  }

  Future<int> deleteOperation(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''UPDATE operations
SET is_deleted = 1
WHERE id = ?;
''', [id]);
  }
}
