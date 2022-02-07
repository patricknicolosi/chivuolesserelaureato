import 'package:animate_do/animate_do.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chivuolesserelaureato/screens/home_screen.dart';
import 'package:chivuolesserelaureato/utils/players.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    _playIntroMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/background.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black38,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Column(
              children: [
                const Spacer(),
                BounceInDown(
                  child: Image.asset("assets/logo.png", width: 500),
                ),
                MaterialButton(
                  color: const Color.fromRGBO(34, 62, 149, 1),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () async {
                    await introAudioPlayer.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "Inizia il gioco",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(),
                  ),
                  MinimizeWindowButton(
                    colors: WindowButtonColors(
                      iconNormal: Colors.white,
                    ),
                  ),
                  CloseWindowButton(
                    colors: WindowButtonColors(
                        mouseOver: const Color(0xFFD32F2F),
                        mouseDown: const Color(0xFFB71C1C),
                        iconNormal: Colors.white,
                        iconMouseOver: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _playIntroMusic() async {
    await introAudioPlayer.setAsset('assets/intro.mp3');
    await introAudioPlayer.play();
    await introAudioPlayer.setLoopMode(LoopMode.all);
  }
}
