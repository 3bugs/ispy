import 'package:flutter/material.dart';
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
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage()),
            );
          },
          child: Image.asset('assets/images/ic_play.png', width: 80.0),
        ),
      ),
    );
  }
}
