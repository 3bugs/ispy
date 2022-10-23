import 'package:flutter/material.dart';
import 'package:ispy/data/words.dart';
import 'package:ispy/models/quiz_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _words = Words();
  QuizModel? _quizModel;

  @override
  void initState() {
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iSpy')),
      body: _quizModel != null
          ? Column(
              children: [
                Expanded(
                  flex: 25,
                  child: Container(
                      child: Image.asset(
                    _quizModel!.alphabetImage,
                  )),
                ),
                Expanded(
                  flex: 75,
                  child: Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildChoiceButton(
                                    _quizModel!.choiceList[0]),
                              ),
                              Expanded(
                                child: _buildChoiceButton(
                                    _quizModel!.choiceList[1]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildChoiceButton(
                                    _quizModel!.choiceList[2]),
                              ),
                              Expanded(
                                child: _buildChoiceButton(
                                    _quizModel!.choiceList[3]),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildChoiceButton(String image) {
    return InkWell(
      onTap: () {
        print(_quizModel!.checkAnswer(image));
      },
      child: Image.asset(image),
    );
  }

  void init(BuildContext context) async {
    await _words.loadMapFromAssets(context);
    newQuiz();
  }

  void newQuiz() {
    setState(() {
      var randomAlphabet = _words.randomAlphabet();
      _quizModel = QuizModel(
          randomAlphabet, 'assets/alphabet_images/' + randomAlphabet + '.jpg');

      var choiceList = _words.randomChoice(randomAlphabet);
      _quizModel!.choiceList.addAll(choiceList);
    });
  }
}
