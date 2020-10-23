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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category':category,
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
}
