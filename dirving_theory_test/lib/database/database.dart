import 'dart:io';

import 'package:dirving_theory_test/model/question.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'model/answered_question.dart';

class DBProvider {
  String _questionsTable = 'questions';
  String _answeredQuestionsTable = 'answered_questions';
  String _favoritesTable = 'favorites';
  String _answerId = 'id';
  String _answerCategory = 'category';
  String _answerIsTrue = 'answerIsTrue';

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
        'CREATE TABLE $_favoritesTable('
            '$_answerId INTEGER PRIMARY KEY,'
            'category TEXT,'
            'hasImage INTEGER,'
            'question TEXT,'
            'answer1 TEXT,'
            'answer2 TEXT,'
            'answer3 TEXT,'
            'answer4 TEXT,'
            'rightAnswer TEXT,'
            'explanation TEXT'
            ')'
    );
    await db.execute(
        'CREATE TABLE $_answeredQuestionsTable($_answerId INTEGER PRIMARY KEY,$_answerCategory TEXT,$_answerIsTrue INTEGER)');
    await db.execute('CREATE TABLE $_questionsTable('
        '$_answerId INTEGER PRIMARY KEY,'
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
        await db.query(_questionsTable);
    List<Question> questions = List();
    questionsMapsList.forEach((element) {
      questions.add(Question.fromDbJson(element));
    });
    return questions;
  }

  Future<List<Question>> getQuestionsForCategory(String category) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> questionsMapsList = await db
        .query(_questionsTable, where: 'category = ?', whereArgs: [category]);
    List<Question> questions = List();
    questionsMapsList.forEach((element) {
      questions.add(Question.fromDbJson(element));
    });
    return questions;
  }

  void insertQuestion(Question question) async {
    Database db = await this.database;
    await db.insert(_questionsTable, question.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void insertFavoriteQuestion(Question question) async {
    Database db = await this.database;
    await db.insert(_favoritesTable, question.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateQuestion(Question question) async {
    Database db = await this.database;
    return await db.update(_questionsTable, question.toDbJson(),
        where: 'id = ? ', whereArgs: [question.id]);
  }

  Future<int> deleteQuestion(int id) async {
    Database db = await this.database;
    return await db.delete(_questionsTable, where: 'id=?', whereArgs: [id]);
  }

  Future<List<Question>> getFavoriteQuestions() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> favoriteQuestionsList =
        await db.query(_favoritesTable);
    List<Question> favoriteQuestions = List();
    favoriteQuestionsList.forEach((element) {
      favoriteQuestions.add(Question.fromDbJson(element));
    });
    return favoriteQuestions;
  }

  Future<List<AnsweredQuestion>> getAnsweredQuestions() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> answeredQuestionsMapsList =
        await db.query(_answeredQuestionsTable);
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
        _answeredQuestionsTable,
        where: '$_answerCategory = ?',
        whereArgs: [category]);
    List<AnsweredQuestion> answeredQuestions = List();
    answeredQuestionsMapsList.forEach((element) {
      answeredQuestions.add(AnsweredQuestion.fromMap(element));
    });
    return answeredQuestions;
  }

  void insertAnsweredQuestion(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    await db.insert(_answeredQuestionsTable, answeredQuestion.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateAnsweredQuestion(AnsweredQuestion answeredQuestion) async {
    Database db = await this.database;
    return await db.update(_answeredQuestionsTable, answeredQuestion.toMap(),
        where: '$_answerId = ? ', whereArgs: [answeredQuestion.id]);
  }

  Future<int> deleteAnsweredQuestion(int id) async {
    Database db = await this.database;
    return await db.delete(_answeredQuestionsTable,
        where: '$_answerId=?', whereArgs: [id]);
  }

  Future<int> deleteFavoriteQuestion(int id) async {
    Database db = await this.database;
    return await db.delete(_favoritesTable,
        where: '$_answerId=?', whereArgs: [id]);
  }
}
