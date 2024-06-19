import 'dart:developer';

import 'package:fuel_management_app/Model/operation.dart';
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
    sub_consumer_id INTEGER NOT NULL,
    amount DECIMAL(8, 2),
    description TEXT,
    type TEXT CHECK(type IN ('صرف', 'وارد')),
    foulType TEXT CHECK(foulType IN ('سيري', 'نظامي')),
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

  getLastTen() async {
    Database? database = await db;
    List<Map> re = await database!.query(
      'operations',
      limit: 10,
      orderBy: 'date DESC',
    );
    return re;
  }
}
