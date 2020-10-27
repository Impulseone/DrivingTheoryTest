class Question {
  int id;
  String category;
  bool hasImage;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int rightAnswer;
  String explanation;

  Question(
      {this.id,
      this.category,
      this.hasImage,
      this.question,
      this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.rightAnswer,
      this.explanation});

  static Question fromJson(json) {
    return Question(
      id: json["id"],
      category: json["category"],
      hasImage: json["hasImage"],
      question: json["question"],
      answer1: json["answer_1"],
      answer2: json["answer_2"],
      answer3: json["answer_3"],
      answer4: json["answer_4"],
      rightAnswer: json["right_answer"],
      explanation: json["explanation"],
    );
  }

  static Question fromDbJson(json) {
    return Question(
      id: json["id"],
      category: json["category"],
      hasImage: json["hasImage"] == 1 ? true : false,
      question: json["question"],
      answer1: json["answer1"],
      answer2: json["answer2"],
      answer3: json["answer3"],
      answer4: json["answer4"],
      rightAnswer: int.parse(json["rightAnswer"]),
      explanation: json["explanation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'hasImage': hasImage,
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'rightAnswer': rightAnswer,
      'explanation': explanation,
    };
  }

  Map<String, dynamic> toDbJson() {
    return {
      'id': id,
      'category': category,
      'hasImage': hasImage == true ? 1 : 0,
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'rightAnswer': rightAnswer,
      'explanation': explanation,
    };
  }

  String findRightAnswer(int rightAnswerNumber) {
    switch (rightAnswerNumber) {
      case 1:
        return this.answer1;
      case 2:
        return this.answer2;
      case 3:
        return this.answer3;
      case 4:
        return this.answer4;
      default:
        return this.answer1;
    }
  }
}
