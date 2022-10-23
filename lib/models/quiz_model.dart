class QuizModel {
  final String alphabet;
  final String alphabetImage;
  final List<String> choiceList = [];

  QuizModel(this.alphabet, this.alphabetImage);

  void addChoice(String image) {
    choiceList.add(image);
  }

  bool checkAnswer(String choice) {
    var tmp = choice.replaceAll('assets/quiz_images/', '');
    return tmp.substring(0, 1).toLowerCase() == alphabet.toLowerCase();
  }
}
