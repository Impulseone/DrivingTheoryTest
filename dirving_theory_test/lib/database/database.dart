import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'model/answered_question.dart';

class DBProvider {
  String tableName = 'answered_questions';
  String answerId = 'id';
  String answerCategory = 'category';
  String answerIsTrue = 'answerIsTrue';

  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    return _database != null ? _database : await _initDb();
  }

  Future<Database> _initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'answered_questions.db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($answerId INTEGER PRIMARY KEY,$answerCategory TEXT,$answerIsTrue INTEGER)');
  }

  Future<List<AnsweredQuestion>> getAnsweredQuestions() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> answeredQuestionsMapsList =
        await db.query(tableName);
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestionsMapsList.forEach((element) {
      answeredQuestions.add(AnsweredQuestion.fromMap(element));
    });
    return answeredQuestions;
  }

  Future<List<AnsweredQuestion>> getAnsweredQuestionsCategory(
      String category) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> answeredQuestionsMapsList = await db
        .query(tableName, where: '$answerCategory = ?', whereArgs: [category]);
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestionsMapsList.forEach((element) {
      answeredQuestions.add(AnsweredQuestion.fromMap(element));
    });
    return answeredQuestions;
  }

  void insertAnswer(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    await db.insert(tableName, answeredQuestion.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateAnswer(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    return await db.update(tableName, answeredQuestion.toMap(),
        where: '$answerId = ? ', whereArgs: [answeredQuestion.id]);
  }

  Future<int> deleteAnswer(int id) async {
    Database db = await this.database;
    return await db.delete(tableName, where: '$answerId=?', whereArgs: [id]);
  }
}
