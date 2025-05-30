import 'dart:ffi';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import "package:path/path.dart";
import 'package:tp_sqflite/Models/Article.dart';
import 'package:tp_sqflite/Models/ItemList.dart';

class Databaseclient {
  Database? _database;
  // on va deux tabless
  //table 1 => liste de mes souhaits (id, nom)
  //table 2 => liste des objects  ( id, mom, prix, magasin, image, i du souhait)
  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    //table 1
    await database.execute('''
    CREATE TABLE list (
    id INTEGER PRIMARY KEY ,

    name TEXT NOT NULL

    )
    ''');
    await database.execute('''
    CREATE TABLE article (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL,
    shop TEXT,
    image TEXT,
    list INTEGER
    )
    ''');
  }

  //  function pour obtenir les donnees des listes
  Future<List<ItemList>> allItems() async {
    Database db = await database;
    const query = 'SELECT * FROM list';
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => ItemList.fromMap(map)).toList();
  }

// function pour recuperer les articles d'un list
  Future<List<Article>> articlesFromId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('article', where: 'list=?', whereArgs: [id]);
    return mapList.map((map) => Article.fromMap(map)).toList();
  }

  //function pour ajouter une list sur ma table list
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert('list', {"name": text});
    return true;
  }
// function qui permet d'ajouter oun supprimer une article
  Future<bool> upsert(Article article) async {
    Database db = await database;
    (article.id == null)
        ? article.id = await db.insert('article', article.toMap())
        : await db.update('article', article.toMap(),
            where: 'id= ?', whereArgs: [article.id]);
    return true;
  }

  Future<bool> removeItem(ItemList itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id =?', whereArgs: [itemList.id]);
    //supprimer aussi tous les articles liees
    await db.delete('article', where: 'list = ?', whereArgs: [itemList.id]);
    return true;
  }
}
