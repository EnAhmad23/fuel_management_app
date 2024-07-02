import 'dart:developer';

import 'package:fuel_management_app/Model/consumer.dart';
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
    log(path);
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
    List<Map<String, Object?>> re = await database!.rawQuery(
      '''SELECT 
    s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE o.is_deleted = 0
ORDER BY o.date DESC
LIMIT 10;
''',
    );
    return re;
  }

  Future<List<Map<String, Object?>>> getAllOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
     SELECT 
    s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE o.is_deleted = 0;

''');
    return re;
  }

  Future<List<Map<String, Object?>>> getOp(int opId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
      select * from operations where id = ? and is_deleted=0
    ''', [opId]);
    return re;
  }

  Future<List<Map<String, Object?>>> getDailyOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
     SELECT 
     s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE DATE(date) = DATE('now')
  AND o.is_deleted = 0 and type = 'صرف';

    ''');
    return re;
  }

  Future<List<Map<String, Object?>>> getMontlySubOp(String? type) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
     SELECT 
    s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE o.is_deleted = 0 
    AND type = ?
    AND strftime('%Y-%m', date) = strftime('%Y-%m', 'now')  -- Current month
   
ORDER BY date DESC;


    ''', [type]);
    return re;
  }

  Future<List<Map<String, Object?>>> getWeeklySubOp() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
     SELECT 
    s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE o.is_deleted = 0 
    AND type = 'صرف'
    AND date >= date('now', 'weekday 6', '-7 days')  -- Start of current week (Saturday)
    AND date <= date('now', 'weekday 6')              -- End of current week (Saturday)
ORDER BY date DESC;


    ''');
    return re;
  }

  Future<List<Map<String, Object?>>> getTotalSubOp(String? type) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
    SELECT 
    s.details AS subConsumerDetails,
    c.name AS consumerName,
    o.id,
    o.amount,
    o.description,
    o.type,
    o.foulType,
    o.receiverName,
    o.dischangeNumber,
    o.date,
    o.checked
FROM operations AS o
LEFT JOIN sub_consumers s ON o.sub_consumer_id = s.id
LEFT JOIN consumers c ON s.consumer_id = c.id
WHERE type = ?
    AND o.is_deleted = 0;



    ''', [type]);
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

  getDailySarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    date,
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' AND is_deleted = 0
GROUP BY date
ORDER BY date DESC;

''');
    return re.first;
  }

  getMonthlySarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    strftime('%Y-%m', date) AS month,
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' AND is_deleted = 0
GROUP BY strftime('%Y-%m', date)
ORDER BY month DESC;


''');
    return re.first;
  }

  getWeeklySarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    strftime('%Y-%W', date) AS week, 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' AND is_deleted = 0
GROUP BY week
ORDER BY week DESC;



''');
    return re.first;
  }

  getTotalSarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' AND is_deleted = 0;




''');
    return re.first;
  }

  getMonthlyWard() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    COALESCE(SUM(amount), 0) AS total_amount
FROM operations
WHERE is_deleted = 0
    AND type = 'وارد'
    AND strftime('%Y-%m', date) = strftime('%Y-%m', 'now');


''');
    log('${re.first}');
    return re.first;
  }

  getTotalWard() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'وارد' AND is_deleted = 0;




''');
    return re.first;
  }

  getTotalAvailable() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    (SELECT COALESCE(SUM(amount), 0) FROM operations WHERE type = 'وارد' AND is_deleted = 0) -
    (SELECT COALESCE(SUM(amount), 0) FROM operations WHERE type = 'صرف' AND is_deleted = 0) AS net_amount;
''');
    return re.first;
  }

  Future<List<Map<String, Object?>>> getSubconsumerForTable() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery("""
   SELECT 
    sc.id,
    c.name AS consumerName,
    sc.details,
    sc.description,
    sc.hasRecord ,
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
    log('$result');
    return result;
  }

  Future<List<Map<String, Object?>>> getConsumersNames() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!
        .rawQuery('SELECT name FROM consumers where is_deleted=0');
    return re;
  }

  getFuelAvailabel() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''
   SELECT
    foulType,
    SUM(CASE WHEN type = 'وارد' THEN amount ELSE 0 END) -
    SUM(CASE WHEN type = 'صرف' THEN amount ELSE 0 END) AS net_amount
FROM
    operations
WHERE
    is_deleted = 0
GROUP BY
    foulType;


''');
    log('availbe $re');
    return re;
  }

  Future<String?> getConsumersName(int? subId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        'SELECT name FROM consumers as c join sub_consumers as sub on c.id=sc.consumer_id  where is_deleted=0 and sc.id=? ');
    return re.isNotEmpty ? re.first['name'].toString() : null;
  }

  Future<List<Map<String, Object?>>> getSubconsumersNames(
      String? conName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''SELECT
    
    s.details
FROM
    consumers c
JOIN
sub_consumers as s
     ON s.consumer_id = c.id
WHERE
    s.is_deleted = 0
    AND c.is_deleted = 0
    AND c.name = ?;
''', [conName]);
    log('subcon names -> ${re.length}');
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

  Future<int?> getNumOfSubconsumers() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select COUNT(DISTINCT id) from sub_consumers  where  is_deleted=0''');
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

  Future<int> updateSubonsumer(SubConsumer subconsumer) async {
    Database? database = await db;
    int? consumerID = await getConsumerID(subconsumer.consumerName);
    log('consumerName ${subconsumer.consumerName}');
    log('${subconsumer.id}');

    return await database!.rawUpdate('''
    update sub_consumers  set 
    details= ?,
    description = ?,
    consumer_id = ? ,
    hasRecord = ?
    where id = ?
    ''', [
      subconsumer.details,
      subconsumer.description,
      consumerID,
      subconsumer.hasRcord! ? 1 : 0,
      subconsumer.id
    ]);
  }

  Future<int?> updateOperation(OperationT? operation) async {
    Database? database = await db;

    // Await the Future to get the actual sub_consumer_id
    int? subConsumerId = await getSubonsumerID(operation?.subConsumerDetails);

    var x = await database?.rawUpdate('''
    UPDATE operations
    SET
      sub_consumer_id = ?, 
      amount = ?, 
      description = ?, 
      type = ?, 
      foulType = ?, 
      receiverName = ?, 
      dischangeNumber = ?, 
      date = ?, 
      checked = ?
    WHERE id = ?
  ''', [
      subConsumerId,
      operation?.amount,
      operation?.description,
      operation?.type,
      operation?.foulType,
      operation?.receiverName,
      operation?.dischangeNumber,
      DateFormat('yyyy-MM-dd').format(
          operation?.newDate! ?? DateTime.now()), // Format the date correctly
      operation?.checked ?? false ? 1 : 0,
      operation?.id, // Make sure the operation object includes the id
    ]);
    log('update -> $x');
    return x;
  }

  Future<int> updateConsumer(AppConsumers consumer) async {
    Database? database = await db;
    log('consumer name -> ${consumer.name}');
    log('consumer id -> ${consumer.id}');
    var x = await database!.rawUpdate('''
    update consumers set name =? where id =?
    ''', [consumer.name, consumer.id]);
    log('update Consumer -> $x');
    return x;
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
