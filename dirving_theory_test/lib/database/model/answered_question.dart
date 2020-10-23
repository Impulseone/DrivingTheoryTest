class AnsweredQuestion {
  int id;
  String category;
  int answerIsTrue;

  AnsweredQuestion(this.id, this.category, this.answerIsTrue); //1=true, 0=false

  Map<String, dynamic> toMap() {
    return {'id': id, 'category': category, 'answerIsTrue': answerIsTrue};
  }

  AnsweredQuestion.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    category = map['category'];
    answerIsTrue = map['answerIsTrue'];
  }
}
