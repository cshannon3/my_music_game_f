import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';
import 'package:my_music_game_f/models/finishedgame.dart';
class GameHistoryDatabase {
  // want to create an instance of our movie db inside our moviedb class
  static final GameHistoryDatabase _instance = GameHistoryDatabase._internal();

  //factory allows you to create many instances of your database
  factory GameHistoryDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  GameHistoryDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDB = await openDatabase(path, version: 3, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE GameHistory(id INTEGER PRIMARY KEY, game_type TEXT, score REAL, time TEXT, date TEXT )''');

    print("Database was Created!");

  }

  Future<int> addGame(finishedGame game) async {
    var dbClient = await db;
    int res = await dbClient.insert("GameHistory", game.toMap());
    return res;
  }

  Future<List<finishedGame>> getAllHistory() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("GameHistory");
    return res.map((m) => finishedGame.fromOfflineDB(m)).toList();
  }

}