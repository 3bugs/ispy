import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ispy/pages/game/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GamePage()),
                      );
                    },
                    child:
                    Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                  const SizedBox(width: 30.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GamePage()),
                      );
                    },
                    child:
                    Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    playBackgroundMusic();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  Future<void> playBackgroundMusic() async {
    /*var audioCache = AudioCache(prefix: "sounds/");
    instance = await audioCache.loop("bg.mp3");*/

    /*final audioPlayer = AudioPlayer();
    //await audioPlayer.setSource(AssetSource('assets/sounds/bg.mp3'));
    await audioPlayer.play(AssetSource('sounds/bg.mp3'));
    audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.
    });*/
  }
}
