// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'diaryModel/diaryModel.dart';

class Databaseprovider {
  static const _databaseName = "dogdatabase.db";
  static const _databaseVersion = 1;

  static const dogTable = 'transactions';
  static const dogId = 'id';
  static const dogName = 'transactioncategorytype';
  static const buyDate = 'date';
  static const dogAge = 'amount';
  static const dogBreed = 'description';
  static const dogColor = 'transactionType';

  Databaseprovider._privateconstructor();
  static final Databaseprovider instance =
      Databaseprovider._privateconstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE $dogTable("
        "$dogId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$dogName TEXT ,"
        "$buyDate TEXT ,"
        "$dogAge TEXT ,"
        "$dogBreed TEXT ,"
        "$dogColor TEXT "
        ")");
  }

  addTransaction(DogModel transactionModel) async {
    Database newdb = await instance.database;
    return await newdb.insert(
      dogTable,
      transactionModel.todatabaseJson(),
    );
  }

  Future<List<DogModel>> getAllTransactions() async {
    final db = await instance.database;
    final List<Map<String, Object?>> newallData = await db.query(dogTable);
    log('Transactions $dogTable');
    return newallData.map((e) => DogModel.fromdatabaseJson(e)).toList();
  }

  Future<void> deleteTransaction(int? id) async {
    final newdb = await instance.database;
    await newdb.delete(
      dogTable,
      where: "$dogId = ?",
      whereArgs: [id],
    );
  }

  updateTransaction(DogModel transactionModel) async {
    final newdb = await database;
    var result = await newdb.update(dogTable, transactionModel.todatabaseJson(),
        where: "$dogId = ?", whereArgs: [transactionModel.id]);
    return result;
  }
}
