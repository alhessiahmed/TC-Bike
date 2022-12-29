import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  late Database _database;

  static DbController? _instance;
  DbController._();
  factory DbController() {
    return _instance ??= DbController._();
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'tc_bike.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database database) {
        // print('db opened');
      },
      onCreate: (Database database, int version) async {
        // print('db created');
        await database.execute('CREATE TABLE cart ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'image_url TEXT NOT NULL,'
            'price REAL NOT NULL,'
            'offer_price REAL,'
            'order_quantity INTEGER NOT NULL,'
            'product_quantity INTEGER NOT NULL,'
            'user_id INTEGER NOT NULL,'
            'product_id INTEGER NOT NULL'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // print('db upgraded');
      },
      onDowngrade: (Database db, int oldVersion, int newVersion) {
        // print('db downgraded');
      },
    );
  }
}
