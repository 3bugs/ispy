import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ispy/etc/utils.dart';
import 'package:ispy/pages/game/game_page.dart';

var infoText =
    '''A game is a structured form of play, usually undertaken for entertainment or fun, and sometimes used as an educational tool.[1] Many games are also considered to be work (such as professional players of spectator sports or games) or art (such as jigsaw puzzles or games involving an artistic layout such as Mahjong, solitaire, or some video games).

Games are sometimes played purely for enjoyment, sometimes for achievement or reward as well. They can be played alone, in teams, or online; by amateurs or by professionals. The players may have an audience of non-players, such as when people are entertained by watching a chess championship. On the other hand, players in a game may constitute their own audience as they take their turn to play. Often, part of the entertainment for children playing a game is deciding who is part of their audience and who is a player. A toy and a game are not the same. Toys generally allow for unrestricted play whereas games come with present rules.

Key components of games are goals, rules, challenge, and interaction. Games generally involve mental or physical stimulation, and often both. Many games help develop practical skills, serve as a form of exercise, or otherwise perform an educational, simulational, or psychological role.

Attested as early as 2600 BC,[2][3] games are a universal part of human experience and present in all cultures. The Royal Game of Ur, Senet, and Mancala are some of the oldest known games.''';

var policyText =
    '''A website’s privacy policy outlines how your site collects, uses, shares, and sells the personal information of your visitors. If you collect personal information from users, you need a privacy policy on your website in most jurisdictions. Even if you aren’t subject to privacy policy laws, being transparent with users about how you collect and handle their data is a best business practice in today’s digital world.

Our simple privacy policy template will help you comply with strict privacy laws and build trust with your users.

Download the free privacy policy template at the bottom of this page, or copy and paste the full text onto your site. If you’d rather let us help you customize a document that’s tailored specifically to your business, our privacy policy generator will create one for you in minutes.''';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _audioPlayer = AudioPlayer();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  var _firstAnimLoop = true;
  late final Animation<double> _animation = Tween<double>(
    begin: 0.6,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        var delay = _firstAnimLoop ? 0 : 2000;
        _firstAnimLoop = false;
        Future.delayed(
            Duration(milliseconds: delay), () => _controller.reverse());
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

  var _showPopup = false;
  var _popupTitle = '';
  var _popupText = '';

  late InterstitialAd _interstitialAd;

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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                  const SizedBox(height: 80.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _handleClickPlay,
                        child: SizedBox(
                          height: 160.0,
                          width: 160.0,
                          child: Center(
                            child: ScaleTransition(
                              scale: _animation,
                              child: Image.asset(
                                'assets/images/ic_play_red.png',
                                //width: 150.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*const SizedBox(width: 30.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GamePage()),
                          );
                        },
                        child:
                        Image.asset('assets/images/ic_new_quiz_on.png', width: 100.0),
                      ),*/
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _popupTitle = 'Information';
                              _popupText = infoText;
                              _showPopup = true;
                            });
                          },
                          child: Image.asset(
                            'assets/images/ic_info.png',
                            width: 100.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _popupTitle = 'Privacy Policy';
                              _popupText = policyText;
                              _showPopup = true;
                            });
                          },
                          child: Image.asset(
                            'assets/images/ic_policy.png',
                            width: 100.0,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            openUrl('https://www.google.com/');
                          },
                          child: SizedBox(
                            height: 90.0,
                            /*decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                            ),*/
                            child:
                                Image.asset('assets/images/ic_more_games.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_showPopup)
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 6,
                        blurRadius: 12,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _popupTitle,
                              style: GoogleFonts.sriracha(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _showPopup = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade300,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _popupText,
                                style: GoogleFonts.sriracha(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller.forward();
    playBackgroundMusic();

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            // ผูก callback เพื่อกำหนดโค้ดในอีเวนต์ต่างๆของโฆษณา
            ad.fullScreenContentCallback =
                FullScreenContentCallback(
                  onAdShowedFullScreenContent: (InterstitialAd ad) =>
                      debugPrint('%ad onAdShowedFullScreenContent.'),
                  onAdDismissedFullScreenContent: (InterstitialAd ad) {
                    debugPrint('$ad onAdDismissedFullScreenContent.');
                    //ad.dispose();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GamePage()),
                    );
                  },
                  onAdFailedToShowFullScreenContent:
                      (InterstitialAd ad, AdError error) {
                    debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
                    ad.dispose();
                  },
                  onAdImpression: (InterstitialAd ad) =>
                      debugPrint('$ad impression occurred.'),
                );
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> playBackgroundMusic() async {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.setVolume(0.1);
    await _audioPlayer.play(AssetSource('sounds/bg2.mp3'));
  }

  void _handleClickPlay() {
    // แสดงโฆษณา
    _interstitialAd.show();

    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GamePage()),
    );*/
  }
}
