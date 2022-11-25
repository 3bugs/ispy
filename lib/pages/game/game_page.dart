import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ispy/data/words.dart';
import 'package:ispy/etc/utils.dart';
import 'package:ispy/models/alphabet_model.dart';
import 'package:ispy/models/quiz_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  final _words = Words();
  QuizModel? _quizModel;
  final List<AnimationController> _controllerList = [];
  final List<int> _rotateDirectionList = [];
  final List<double> _randomValueList = [];
  final List<Animation> _animationList = [];
  var _currentSolutionIndex = -1;
  final _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    init();

    for (var i = 0; i < 5; i++) {
      _rotateDirectionList.add(1);
      _randomValueList.add(Random().nextDouble() * 2);

      var controller = AnimationController(
        duration: Duration(milliseconds: (Random().nextInt(2000) + 2000)),
        vsync: this,
      );
      _controllerList.add(controller);

      var curveList = [Curves.easeInOut, Curves.easeInBack, Curves.ease];
      var animation = Tween<double>(
        begin: 0.0,
        end: Random().nextInt(5) * 0.1 + 0.25,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: curveList[Random().nextInt(curveList.length)],
      ))
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
            _rotateDirectionList[i] *= Random().nextInt(2) == 0 ? 1 : -1;
          }
        });

      _animationList.add(animation);
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_game.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _quizModel != null
            ? (_quizModel!.solved ? _buildSolution() : _buildQuiz())
            : const Center(
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: CircularProgressIndicator(strokeWidth: 8.0),
                ),
              ),
      ),
    );
  }

  Widget _buildSolution() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset(_quizModel!.alphabetImage),
              Image.asset(
                  'assets/alphabet_images/${QuizModel.solvedAlphabetList[_currentSolutionIndex].alphabet}.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  '=',
                  style: GoogleFonts.sriracha(
                    fontWeight: FontWeight.bold,
                    fontSize: 120.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Image.asset(
                  QuizModel.solvedAlphabetList[_currentSolutionIndex].image),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                QuizModel.solvedAlphabetList[_currentSolutionIndex].alphabet
                    .toUpperCase(),
                style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
              Text(
                ' is for ',
                style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Text(
                QuizModel.solvedAlphabetList[_currentSolutionIndex].alphabet
                    .toUpperCase(),
                style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
              Text(
                QuizModel.solvedAlphabetList[_currentSolutionIndex].word
                    .toUpperCase()
                    .substring(1),
                style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                  fontSize: 60.0,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildNavButton(0),
                  _buildNavButton(1),
                  _buildNavButton(2),
                ],
              ),
              _buildNavButton(4),
              _buildNavButton(3),
            ],
          ),
        )
      ],
    );
  }

  Padding _buildNavButton(int index) {
    var image = '';
    switch (index) {
      case 0:
        image = _currentSolutionIndex == 0
            ? 'assets/images/ic_back_off.png'
            : 'assets/images/ic_back_on.png';
        break;
      case 1:
        image = 'assets/images/ic_home.png';
        break;
      case 2:
        image = _currentSolutionIndex == QuizModel.solvedAlphabetList.length - 1
            ? 'assets/images/ic_forward_off.png'
            : 'assets/images/ic_forward_on.png';
        break;
      case 3:
        image = 'assets/images/ic_new_quiz_on.png';
        /*image = _words.getNumAlphabet() == QuizModel.solvedAlphabetList.length
            ? 'assets/images/ic_new_quiz_off.png'
            : 'assets/images/ic_new_quiz_on.png';*/
        break;
      case 4: // play sound (TTS)
        image = 'assets/images/ic_sound.png';
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:
              // go back
              setState(() {
                if (_currentSolutionIndex > 0) {
                  _currentSolutionIndex--;
                }
              });
              break;
            case 1:
              if (_words.getNumAlphabet() ==
                  QuizModel.solvedAlphabetList.length) {
                QuizModel.solvedAlphabetList.clear();
              }
              Navigator.pop(context);
              break;
            case 2:
              // go forward
              setState(() {
                if (_currentSolutionIndex <
                    QuizModel.solvedAlphabetList.length - 1) {
                  _currentSolutionIndex++;
                }
              });
              break;
            case 3:
              if (_words.getNumAlphabet() !=
                  QuizModel.solvedAlphabetList.length) {
                newQuiz();
              } else {
                openUrl('https://www.google.com/');
              }
              break;
            case 4: // play sound (TTS)
              _playTtsSound();
              break;
          }
        },
        child: Image.asset(image, width: 80.0), // ขนาดปุ่ม
      ),
    );
  }

  Widget _buildQuiz() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  //color: Colors.yellow,
                  child: _buildChoiceButton(0),
                ),
              ),
              Expanded(
                child: Image.asset(_quizModel!.alphabetImage),
              ),
              Expanded(
                child: Container(
                  //color: Colors.lightBlueAccent,
                  child: _buildChoiceButton(1),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  //color: Colors.pink,
                  child: _buildChoiceButton(2),
                ),
              ),
              Expanded(
                child: Container(
                  //color: Colors.purpleAccent,
                  child: _buildChoiceButton(3),
                ),
              ),
              Expanded(
                child: Container(
                  //color: Colors.lightGreenAccent,
                  child: _buildChoiceButton(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceButton(int choiceIndex) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            if (_quizModel!.checkAnswer(_quizModel!.choiceList[choiceIndex])) {
              //_feedback = 'Good Job!';
              _quizModel!.solved = true;
              QuizModel.solvedAlphabetList.add(
                AlphabetModel(
                  alphabet: _quizModel!.alphabet,
                  image: _quizModel!.getAnswer(),
                  word: _quizModel!.getAnswerWord(),
                ),
              );
              _currentSolutionIndex = QuizModel.solvedAlphabetList.length - 1;

              _playTtsSound();

              debugPrint('Solved alphabets: ${QuizModel.solvedAlphabetList}');
            } else {
              //_feedback = 'Sorry, please try again.';
              _quizModel!.visibleList[choiceIndex] = false;
            }
          });
        },
        child: _quizModel!.visibleList[choiceIndex]
            ? AnimatedBuilder(
                animation: _animationList[choiceIndex],
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: _rotateDirectionList[choiceIndex] *
                        _animationList[choiceIndex].value *
                        1.0,
                    child: Image.asset(_quizModel!.choiceList[choiceIndex]),
                  );
                })
            : const SizedBox.shrink(),
      ),
    );
  }

  void init() async {
    await _words.loadMapFromAssets(context);
    newQuiz();
  }

  void newQuiz() {
    setState(() {
      var randomAlphabet = _words.randomAlphabet();
      _quizModel = QuizModel(
        randomAlphabet,
        'assets/alphabet_images/$randomAlphabet.png',
      );

      var choiceList = _words.randomChoice(randomAlphabet);
      _quizModel!.choiceList.addAll(choiceList);
      _quizModel!.visibleList
          .addAll(List<bool>.filled(choiceList.length, true));
    });
  }

  Future<void> _playTtsSound() async {
    /*var defaultVoice = await _flutterTts.getDefaultVoice;
    print(defaultVoice);*/

    //await _flutterTts.setVoice({"name": "Karen"});
    var msg =
        '${QuizModel.solvedAlphabetList[_currentSolutionIndex].alphabet.toUpperCase()} is for ${QuizModel.solvedAlphabetList[_currentSolutionIndex].alphabet.toUpperCase()}${QuizModel.solvedAlphabetList[_currentSolutionIndex].word.toUpperCase().substring(1)}';
    // play sound (TTS)
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setSpeechRate(0.3);
    await _flutterTts.speak(msg);
  }
}
