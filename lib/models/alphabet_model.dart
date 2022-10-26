class AlphabetModel {
  final String alphabet;
  final String image;
  final String word;

  AlphabetModel({
    required this.alphabet,
    required this.image,
    required this.word,
  });

  @override
  String toString() {
    return '$alphabet - $image - $word';
  }
}
