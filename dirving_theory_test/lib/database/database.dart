import 'dart:io';

import 'package:dirving_theory_test/model/question.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'model/answered_question.dart';

class DBProvider {
  String questionsTable = 'questions';
  String answeredQuestionsTable = 'answered_questions';
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
    String path = directory.path + 'questions.db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $answeredQuestionsTable($answerId INTEGER PRIMARY KEY,$answerCategory TEXT,$answerIsTrue INTEGER)');
    await db.execute('CREATE TABLE $questionsTable('
        'id INTEGER PRIMARY KEY,'
        'category TEXT,'
        'hasImage INTEGER,'
        'question TEXT,'
        'answer1 TEXT,'
        'answer2 TEXT,'
        'answer3 TEXT,'
        'answer4 TEXT,'
        'rightAnswer TEXT,'
        'explanation TEXT'
        ')');
  }

  Future<List<Question>> getQuestions() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> questionsMapsList =
        await db.query(questionsTable);
    List<Question> questions = List();
    questionsMapsList.forEach((element) {
      questions.add(Question.fromDbJson(element));
    });
    return questions;
  }

  Future<List<Question>> getQuestionsForCategory(String category) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> questionsMapsList = await db
        .query(questionsTable, where: 'category = ?', whereArgs: [category]);
    List<Question> questions = List();
    questionsMapsList.forEach((element) {
      questions.add(Question.fromDbJson(element));
    });
    return questions;
  }

  void insertQuestion(Question question) async {
    Database db = await this.database;
    await db.insert(questionsTable, question.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateQuestion(Question question) async {
    Database db = await this.database;
    return await db.update(questionsTable, question.toDbJson(),
        where: 'id = ? ', whereArgs: [question.id]);
  }

  Future<int> deleteQuestion(int id) async {
    Database db = await this.database;
    return await db.delete(questionsTable, where: 'id=?', whereArgs: [id]);
  }

  Future<List<AnsweredQuestion>> getAnsweredQuestions() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> answeredQuestionsMapsList =
        await db.query(answeredQuestionsTable);
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestionsMapsList.forEach((element) {
      answeredQuestions.add(AnsweredQuestion.fromMap(element));
    });
    return answeredQuestions;
  }

  Future<List<AnsweredQuestion>> getAnsweredQuestionsForCategory(
      String category) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> answeredQuestionsMapsList = await db.query(
        answeredQuestionsTable,
        where: '$answerCategory = ?',
        whereArgs: [category]);
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestionsMapsList.forEach((element) {
      answeredQuestions.add(AnsweredQuestion.fromMap(element));
    });
    return answeredQuestions;
  }

  void insertAnsweredQuestion(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    await db.insert(answeredQuestionsTable, answeredQuestion.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateAnsweredQuestion(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    return await db.update(answeredQuestionsTable, answeredQuestion.toMap(),
        where: '$answerId = ? ', whereArgs: [answeredQuestion.id]);
  }

  Future<int> deleteAnsweredQuestion(int id) async {
    Database db = await this.database;
    return await db
        .delete(answeredQuestionsTable, where: '$answerId=?', whereArgs: [id]);
  }
}
