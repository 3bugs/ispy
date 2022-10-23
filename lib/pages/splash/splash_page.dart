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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'iSpy',
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
            Expanded(child: Image.asset('assets/images/kids.png')),
            CircularProgressIndicator(strokeWidth: 5),
            Text(
              ' ',
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        )),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }
}
