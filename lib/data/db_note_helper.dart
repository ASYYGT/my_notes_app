import 'dart:async';

import 'package:daily_app/data/db_helper.dart';
import 'package:daily_app/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class DbNoteHelper extends DbHelper {
  Database? _db;

  Future<Database> get db async {
    _db ??= await super.initializeDb();
    return _db!;
  }

  Future<List<NoteModel>> getNotes() async {
    Database db = await this.db;
    List<NoteModel> noteModelList;
    var result = await db.query("notes");
    noteModelList = result.map((data) => NoteModel.fromJson(data)).toList();
    return noteModelList;
  }

  Future<int> insertNote(NoteModel noteModel) async {
    Database db = await this.db;
    var result = 0;
    if (noteModel.id == -1) {
      var randomId = Random().nextInt(1000);
      await checkId(randomId).then((value) async {
        noteModel.id = value;
        result = await db.insert("notes", noteModel.toJson());
      });
      return result;
    } else {
      result = await db.insert("notes", noteModel.toJson());
      return result;
    }
  }

  Future<int> deleteNote(int noteId) async {
    Database db = await this.db;
    var result = await db.delete("notes", where: "id=?", whereArgs: [noteId]);
    return result;
  }

  Future<int> updateNote(NoteModel noteModel) async {
    Database db = await this.db;
    var result = await db.update("notes", noteModel.toJson(),
        where: "id=?", whereArgs: [noteModel.id]);
    return result;
  }

  Future<int> checkId(int id) async {
    Database db = await this.db;
    bool isInsert = false;
    dynamic isExsits;
    while (isInsert == false) {
      isExsits = await db.rawQuery('''SELECT id FROM notes WHERE id==$id;''');
      if (isExsits.isEmpty) {
        isInsert = true;
      } else {
        id = Random().nextInt(1000);
      }
    }
    return id;
  }
}
