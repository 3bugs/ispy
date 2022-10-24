class QuizModel {
  final String alphabet;
  final String alphabetImage;
  final List<String> choiceList = [];
  final List<bool> visibleList = [];
  bool solved = false;

  QuizModel(this.alphabet, this.alphabetImage);

  /*void addChoice(String image) {
    choiceList.add(image);
    visibleList.add(true);
  }*/

  bool checkAnswer(String choice) {
    var tmp = choice.replaceAll('assets/quiz_images/', '');
    return tmp.substring(0, 1).toLowerCase() == alphabet.toLowerCase();
  }

  String getAnswer() {
    return choiceList.where((choice) => checkAnswer(choice)).toList()[0];
  }

  String getAnswerWord() {
    return getAnswer()
        .replaceAll('assets/quiz_images/', '')
        .split('/')[1]
        .replaceAll('.png', '')
        .replaceAll('.gif', '')
        .replaceAll('.jpg', '');
  }

  void updateChoiceVisible(int index, bool value) {
    visibleList[index] = value;
  }
}
