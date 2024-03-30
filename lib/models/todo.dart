import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Todo {
  static Future<Database> _database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, statut BOOLEAN DEFAULT false)");
      },
      version: 1,
    );
  }

  static Future<int> insertTodo(String name, String date) async {
    final db = await _database();
    final data = {
      'name': name,
      'date': DateTime.now().toString(),
    };
    return await db.insert('todo', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTodo(int id, String name, String date, bool statut) async {
    final db = await _database();
    final data = {'name': name, 'date': date, 'statut': statut};
    return await db.update(('todo'), data,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteTodo(int id) async {
    final db = await _database();
    try {
      await db.delete('todo', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("il y a une erreur $err");
    }
  }

  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps =
        await db.query('todo', orderBy: "id");
    return maps;
  }

  static Future<List<Map<String, dynamic>>> getTodo(int id) async {
    final db = await _database();
    return await db.query('todo', where: 'id = ?', whereArgs: [id], limit: 1);
  }
}
