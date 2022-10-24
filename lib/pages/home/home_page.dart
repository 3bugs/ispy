import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? _feedback;

  @override
  void initState() {
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('I SPY')),
      body: _quizModel != null
          ? Column(
              children: [
                Expanded(
                  flex: 25,
                  child: Image.asset(
                    _quizModel!.alphabetImage,
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: Container(
                      color: Colors.blue.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildChoiceButton(_quizModel!.choiceList[0]),
                              _buildChoiceButton(_quizModel!.choiceList[1]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildChoiceButton(_quizModel!.choiceList[2]),
                              _buildChoiceButton(_quizModel!.choiceList[3]),
                            ],
                          ),
                        ],
                      )),
                ),
                _feedback != null
                    ? Text(
                        _feedback!,
                        style: GoogleFonts.kanit(fontSize: 36),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildChoiceButton(String image) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //borderRadius: BorderRadius.circular(114),
        onTap: () {
          setState(() {
            if (_quizModel!.checkAnswer(image)) {
              _feedback = 'Good Job!';
            } else {
              _feedback = 'Sorry, please try again.';
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 108,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: CircleAvatar(
              //backgroundImage: AssetImage(image),
              foregroundImage: AssetImage(image),
              radius: 100,
            ),
          ),
        ),
        /*child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5),
          ),
          child: Image.asset(image),
        ),*/
      ),
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
        randomAlphabet,
        'assets/alphabet_images/$randomAlphabet.jpg',
      );

      var choiceList = _words.randomChoice(randomAlphabet);
      _quizModel!.choiceList.addAll(choiceList);
    });
  }
}
