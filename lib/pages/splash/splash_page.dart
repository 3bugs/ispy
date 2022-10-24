import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ispy/pages/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              'I SPY',
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
            Expanded(child: Image.asset('assets/images/kids.png')),
            const CircularProgressIndicator(strokeWidth: 5),
            Text(
              ' ',
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold,
                fontSize: 60,
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

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
    );
  }
}
