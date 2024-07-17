import 'dart:developer';
import 'dart:io';

import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/Model/operation.dart';
import 'package:fuel_management_app/Model/operationT.dart';
import 'package:fuel_management_app/Model/subconsumerT.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:fuel_management_app/Model/user.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<void> backupDatabase() async {
    try {
      // Get the database path
      var databasesPath = await getDatabasesPath();
      var dbPath = join(databasesPath, 'fuel_managment.db');

      // Get the backup path (e.g., external storage directory)
      Directory? backupDirectory = await getExternalStorageDirectory();
      var backupPath = join(backupDirectory!.path, 'backup_fuel_managment.db');

      // Copy the database file to the backup location
      await File(dbPath).copy(backupPath);
      log('Database backup completed!');
    } catch (e) {
      log('Error during backup: $e');
    }
  }

  Future<void> restoreDatabase() async {
    try {
      // Get the database path
      var databasesPath = await getDatabasesPath();
      var dbPath = join(databasesPath, 'fuel_managment.db');

      // Get the backup path (e.g., external storage directory)
      Directory? backupDirectory = await getExternalStorageDirectory();
      var backupPath =
          join(backupDirectory?.path ?? '', 'backup_fuel_managment.db');

      // Copy the backup file to the database location
      await File(backupPath).copy(dbPath);
      log('Database restore completed!');
    } catch (e) {
      log('Error during restore: $e');
    }
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
    type TEXT CHECK(type IN ('صرف', 'وارد')),
    foulType TEXT CHECK(foulType IN ('بنزين', 'سولار')),
    receiverName TEXT,
    dischangeNumber TEXT,
    date DATE,
    checked INTEGER DEFAULT 0,
    is_close INTEGER DEFAULT 0,
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
CREATE TABLE trips (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sub_consumer_id INTEGER,
    road TEXT NOT NULL,
    cause TEXT NOT NULL,
    date DATE,
    is_close INTEGER DEFAULT 0,
    status TEXT CHECK(status IN ('منشأة', 'منتهية', 'ملغاه','قيد التنفيذ')),
    recordBefore TEXT,
    recordAfter TEXT,
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
WHERE o.is_close=0
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
Where is_close = 0

''');
    return re;
  }

  Future<List<Map<String, Object?>>> getAllSubOp(int? id) async {
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
where s.id = ? and o.is_close

''', [id]);
    return re;
  }

  Future<List<Map<String, Object?>>> getOp(int opId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
      select * from operations where id = ? 
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
  AND  type = 'صرف' and o.is_close = 0;

    ''');
    return re;
  }

  getTrips() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''
  SELECT 
    sc.details,
    t.id,
    t.road,
    t.cause,
    t.date,
    t.status,
    t.recordBefore,
    t.recordAfter
FROM 
    trips t
JOIN 
    sub_consumers sc ON t.sub_consumer_id = sc.id
Where t.is_close=0    
ORDER BY 
    t.created_at DESC;
''');
    log('${re}');
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
WHERE o.is_close = 0 
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
WHERE o.is_close = 0 
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
    AND o.is_close = 0;



    ''', [type]);
    return re;
  }

  getNumOfOp(int subconsumerId) async {
    Database? database = await db;
    List<Map<String, dynamic>> re =
        await database!.rawQuery('''SELECT COUNT(*) AS operation_count
    FROM operations
    WHERE sub_consumer_id = ?
      AND type = 'صرف' and is_close=0;
''', [subconsumerId]);
    return Sqflite.firstIntValue(re) ?? 0;
  }

  getNumOfAllOp() async {
    Database? database = await db;
    List<Map<String, dynamic>> re =
        await database!.rawQuery('''SELECT COUNT(*) AS operation_count
    FROM operations
    WHERE is_close=0;
''');
    return Sqflite.firstIntValue(re) ?? 0;
  }

  getDailySarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''
    SELECT SUM(amount) AS total_amount
    FROM operations
    WHERE type = 'صرف'
      AND date = DATE('now') and is_close = 0;


''');
    return Sqflite.firstIntValue(re) ?? 0;
  }

  getMonthlySarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    strftime('%Y-%m', date) AS month,
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' AND is_close = 0
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
WHERE type = 'صرف' AND is_close = 0
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
WHERE type = 'صرف' AND is_close = 0;




''');
    return re.first;
  }

  getTotalSolarSarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' and foulType='سولار' AND is_close = 0;
''');
    return re.first;
  }

  Future<double> getDistanceBetweenLastTwoRecords(int subConsumerID) async {
    Database? database = await db;
    List<Map<String, dynamic>> result = await database!.rawQuery('''
    SELECT 
        sub1.id AS id1, 
        sub1.record AS record1,
        sub2.id AS id2, 
        sub2.record AS record2,
        ABS(sub1.record - sub2.record) AS distance_km
    FROM 
        (SELECT id, record 
         FROM movement_records 
         WHERE sub_consumer_id = ? 
         ORDER BY date DESC 
         LIMIT 1 OFFSET 1) sub1,
        (SELECT id, record 
         FROM movement_records 
         WHERE sub_consumer_id = ? 
         ORDER BY date DESC 
         LIMIT 1) sub2;
  ''', [subConsumerID, subConsumerID]);

    if (result.isNotEmpty) {
      double distance = result.first['distance_km']?.toDouble() ?? 0.0;
      return distance;
    } else {
      return 0.0;
    }
  }

  getTotaBansenSarf() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'صرف' and foulType='بنزين' AND is_close = 0;
''');
    return re.first;
  }

  getMonthlyWard() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    COALESCE(SUM(amount), 0) AS total_amount
FROM operations
WHERE is_close = 0
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
WHERE type = 'وارد' AND is_close = 0;
''');
    return re.first;
  }

  getTotalSolarWard() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'وارد' and foulType='سولار' AND is_close = 0;
''');
    return re.first;
  }

  getTotalBanzenWard() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    SUM(amount) AS total_exchange_amount
FROM operations
WHERE type = 'وارد' and foulType='بنزين' AND is_close = 0;
''');
    return re.first;
  }

  getTotalAvailable() async {
    Database? database = await db;
    List<Map<String, dynamic>> re = await database!.rawQuery('''SELECT 
    (SELECT COALESCE(SUM(amount), 0) FROM operations WHERE type = 'وارد' AND is_close = 0) -
    (SELECT COALESCE(SUM(amount), 0) FROM operations WHERE type = 'صرف' AND is_close = 0) AS net_amount;
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
  sc.hasRecord,
  COUNT(o.id) AS numberOfOperations
FROM 
  sub_consumers sc
JOIN 
  consumers c ON sc.consumer_id = c.id
LEFT JOIN 
  operations o ON sc.id = o.sub_consumer_id
WHERE 
  c.is_deleted = 0 AND
  sc.is_deleted = 0 and o.is_close = 0
GROUP BY 
  sc.id, c.name, sc.details, sc.description, sc.hasRecord
ORDER BY 
  sc.id;

  """);
    log('sub length${re.length}');
    log('${re}');
    return re;
  }

  Future<List<Map<String, Object?>>> getSubconsumersOfCon(
      String? conName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery("""
    SELECT 
      sc.id,
      c.name as consumerName,
      sc.details,
      sc.description,
      sc.hasRecord,
      COUNT(o.id) AS numberOfOperations
    FROM 
      sub_consumers sc
    JOIN 
      consumers c ON sc.consumer_id = c.id
    LEFT JOIN 
      operations o ON sc.id = o.sub_consumer_id
    WHERE 
      c.name = ? AND c.is_deleted = 0 AND sc.is_deleted = 0 and o.is_close = 0
    GROUP BY 
      sc.id, sc.details, sc.description
    ORDER BY 
      sc.id
  """, [conName]);
    log('${re.length}');
    log('${re}');
    return re;
  }

  Future<List<Map<String, Object?>>> getConsumerForTable() async {
    Database? database = await db;
    List<Map<String, Object?>> result = await database!.rawQuery('''
    SELECT 
        c.id AS consumer_id,
        c.name AS consumer_name,
        COUNT(DISTINCT CASE WHEN sc.is_deleted = 0 THEN sc.id ELSE NULL END) AS number_of_subconsumers,
        COUNT(DISTINCT CASE WHEN o.is_close = 0 THEN o.id ELSE NULL END) AS number_of_operations
    FROM 
        consumers c
    LEFT JOIN 
        sub_consumers sc ON c.id = sc.consumer_id
    LEFT JOIN 
        operations o ON sc.id = o.sub_consumer_id
    WHERE 
        c.is_deleted = 0
    GROUP BY 
        c.id, c.name
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

  Future<List<Map<String, Object?>>> getMovmentRcords(int subID) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''
    SELECT
      id,
      sub_consumer_id,
      record,
      date
    FROM movement_records 
    WHERE  sub_consumer_id = ?
  ''', [subID]);
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
    is_close = 0
GROUP BY
    foulType;


''');
    log('availbe $re');
    return re;
  }

  Future<String?> getConsumersName(int? subId) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        'SELECT name FROM consumers as c join sub_consumers as sub on c.id=sc.consumer_id  where is_deleted=0 and sc.id=? ',
        [subId]);
    return re.isNotEmpty ? re.first['name'].toString() : null;
  }

  Future<String?> getConsumerName(String? subName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''SELECT name 
FROM consumers AS c 
JOIN sub_consumers AS sub 
ON c.id = sub.consumer_id 
WHERE c.is_deleted = 0 
AND sub.details = ?
''', [subName]);
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

  Future<int?> getSubonsumerHasRecord(String? SubconsumerName) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''Select hasRecord from sub_consumers  where details = ? and is_deleted=0''',
        [SubconsumerName]);
    return Sqflite.firstIntValue(re) ?? -1;
  }

  Future<int?> getNumOfSubconsumers() async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery(
        '''SELECT COUNT(DISTINCT id) FROM sub_consumers WHERE is_deleted = 0''');
    log('+++++++++++++++++++++++++++++$re');
    return Sqflite.firstIntValue(re) ?? 0;
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

  Future<int?> addTrip(Trip trip) async {
    Database? database = await db;
    int? subConsumerId = await getSubonsumerID(trip.subconName);
    return await database?.rawInsert('''
    INSERT INTO Trips (
      sub_consumer_id ,
      road ,
      cause ,
      date ,
      status 
    ) VALUES (?, ?, ?, ?, ?)
  ''', [
      subConsumerId,
      trip.road ?? 'Default Road', // Provide a default value if road is null
      trip.cause,
      DateFormat('yyyy-MM-dd').format(trip.date!), // Format the date correctly
      trip.status,
    ]);
  }

  altTrip() async {
    Database? database = await db;
    await database?.execute(
      '''
    ALTER TABLE trips
ADD COLUMN is_close INTEGER DEFAULT 0;

  ''',
    );
  }

//   altOper() async {
//     Database? database = await db;
//     await database?.execute(
//       '''
//     ALTER TABLE operations
// ADD COLUMN is_close INTEGER DEFAULT 0;

//   ''',
//     );
//   }

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

    var x = await database!.rawInsert('''
    insert into sub_consumers (details,description,consumer_id,hasRecord) values(?,?,?,?)
    ''', [
      subconsumer.details,
      subconsumer.description,
      consumerID,
      subconsumer.hasRcord! ? 1 : 0
    ]);
    if (subconsumer.hasRcord ?? false) {
      int? subConsumerId = await getSubonsumerID(subconsumer.details);
      await database!.rawInsert(
          '''insert into movement_records (sub_consumer_id ,record ,date ) values(?,?,?);''',
          [
            subConsumerId,
            subconsumer.record,
            DateFormat('yyyy-MM-dd').format(subconsumer.date!)
          ]);
    }
    return x;
  }

  addMovementRecord(String subName, int record) async {
    Database? database = await db;
    int? subConsumerId = await getSubonsumerID(subName);

    int lastRecord = await getSubRecord(subConsumerId ?? 0);
    log('llllllllllllllllllllllllllllllll$lastRecord');
    if (record > lastRecord) {
      return await database!.rawInsert('''
  INSERT INTO movement_records (sub_consumer_id, record, date)
  values(?,?,?)
''', [subConsumerId, record, DateFormat('yyyy-MM-dd').format(DateTime.now())]);
    }
    return -1;
  }

  Future<int> getSubRecord(int subId) async {
    Database? database = await db;

    List<Map<String, Object?>> re = await database!.rawQuery('''
  SELECT *
FROM movement_records
WHERE sub_consumer_id = ?
ORDER BY date DESC
LIMIT 1;

''', [subId]);
    return Sqflite.firstIntValue(re) ?? -1;
  }

  Future<int> getSubRecordName(String? subName) async {
    Database? database = await db;
    int? subConsumerId = await getSubonsumerID(subName);
    List<Map<String, Object?>> re = await database!.rawQuery('''
  SELECT *
FROM movement_records
WHERE sub_consumer_id = ?
ORDER BY date DESC
LIMIT 1;

''', [subConsumerId]);
    return Sqflite.firstIntValue(re) ?? -1;
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

  Future<int> updateStartTrip(String? status, int? id) async {
    Database? database = await db;

    var x = await database!.rawUpdate('''
    update trips set status =? where id =?
    ''', [status, id]);
    log('update Consumer -> $x');
    return x;
  }

  Future<int> updateTrip(Trip trip) async {
    Database? database = await db;
    String? dateString = trip.date?.toIso8601String();
    int? subId = await getSubonsumerID(trip.subconName);
    log('id ->${trip.id}');
    var x = await database!.rawUpdate('''
    update trips set sub_consumer_id =? , date = ?,road=?,cause=? where id =?
    ''', [subId, dateString, trip.road, trip.cause, trip.id]);
    log('update Trip -> $x');
    return x;
  }

  Future<int> updateTripRecord(int? record, int? id) async {
    Database? database = await db;
    log('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*$record');
    var x = await database!.rawUpdate('''
    update trips set recordBefore =? where id =?
    ''', [record, id]);
    log('update Consumer -> $x');
    return x;
  }

  Future<int> updateRecordAfter(int? record, int? id) async {
    Database? database = await db;
    log('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*$record');
    var x = await database!.rawUpdate('''
    update trips set recordAfter =? where id =?
    ''', [record, id]);
    log('update Consumer -> $x');
    return x;
  }

  Future<List<Map<String, Object?>>> searchOp(OperationT operation) async {
    Database? database = await db;
    List<Map<String, Object?>> re = await database!.rawQuery('''SELECT 
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
WHERE o.is_close= 0
AND (
    s.details =? OR
    c.name =? OR
    o.amount =? OR
    o.description =?OR
    o.type =?OR
    o.foulType =? OR
    o.receiverName =? OR
    o.dischangeNumber =? OR
    o.date =? OR
    o.checked  =?
);
''', [
      operation.subConsumerDetails,
      operation.consumerName,
      operation.amount,
      operation.description,
      operation.type,
      operation.foulType,
      operation.receiverName,
      operation.dischangeNumber,
      operation.newDate,
      operation.checked
    ]);
    return re;
  }

  Future<int> deleteConsumer(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''UPDATE consumers
SET is_deleted = 1
WHERE id = ?;
''', [id]);
  }

  Future<int> deleteTrip(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''DELETE FROM trips
WHERE id = ?;
''', [id]);
  }

  Future<int> deleteMovementRecord(int id) async {
    Database? database = await db;
    return await database!.rawUpdate('''DELETE FROM movement_records
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

  Future<int> trheilLOperation(int month, int year) async {
    Database? database = await db;
    return await database!.rawUpdate('''
      UPDATE operations
      SET is_close = 1
      WHERE strftime('%m', date) = ?  
        AND strftime('%Y', date) = ?;

    ''', [month, year]);
  }

  Future<int> deleteOperation(int id) async {
    Database? database = await db;
    return database!.delete(
      'operations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isMonthclose(int month, int year) async {
    Database? databae = await db;
    List<Map<String, dynamic>> re = await databae!.rawQuery('''
        SELECT is_close = 1
        FROM operations
        WHERE strftime('%m', date) = ?
          AND strftime('%Y', date) = ?;
    ''', [month, year]);
    return (Sqflite.firstIntValue(re) ?? 0) == 1;
  }

  getMonthes() async {
    Database? databae = await db;
    List<Map<String, dynamic>> re = await databae!.rawQuery('''
       SELECT DISTINCT
      strftime('%m', date) AS month,
      strftime('%Y', date) AS year
      FROM operations
      ORDER BY year, month;
    ''');
    return re;
  }
}
