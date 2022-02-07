import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chivuolesserelaureato/models/helper.dart';
import 'package:chivuolesserelaureato/models/question_answer.dart';
import 'package:chivuolesserelaureato/models/question_line.dart';
import 'package:chivuolesserelaureato/models/question_shape.dart';
import 'package:chivuolesserelaureato/utils/players.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _playBackgroundMusic();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
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
          Column(
            children: [
              Expanded(
                child: Image.asset("assets/logo.png"),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const QuestionLine(),
                        Expanded(
                          child: QuestionShape(
                              _questionAnswers[_index].question,
                              true,
                              () {},
                              false),
                        ),
                        const QuestionLine(),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        const QuestionLine(),
                        Expanded(
                          child: QuestionShape(
                              "A " + _questionAnswers[_index].answers[0], false,
                              () {
                            _check(0);
                          }, _isCorrect(0)),
                        ),
                        const QuestionLine(),
                        Expanded(
                          child: QuestionShape(
                              "B " + _questionAnswers[_index].answers[1], false,
                              () {
                            _check(1);
                          }, _isCorrect(1)),
                        ),
                        const QuestionLine(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const QuestionLine(),
                        Expanded(
                          child: QuestionShape(
                              "C " + _questionAnswers[_index].answers[2], false,
                              () {
                            _check(2);
                          }, _isCorrect(2)),
                        ),
                        const QuestionLine(),
                        Expanded(
                          child: QuestionShape(
                              "D " + _questionAnswers[_index].answers[3], false,
                              () {
                            _check(3);
                          }, _isCorrect(3)),
                        ),
                        const QuestionLine(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                WindowTitleBarBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: MoveWindow(),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: MinimizeWindowButton(
                          animate: true,
                          colors: WindowButtonColors(
                            iconNormal: Colors.white,
                          ),
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: CloseWindowButton(
                          colors: WindowButtonColors(
                              mouseOver: const Color(0xFFD32F2F),
                              mouseDown: const Color(0xFFB71C1C),
                              iconNormal: Colors.white,
                              iconMouseOver: Colors.white),
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Helper(
                          const Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                          "Aiuto da casa",
                          () {}),
                      const SizedBox(width: 15),
                      Helper(
                        const Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 30,
                        ),
                        "Aiuto dal pubblico",
                        () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                "Aiuto del pubblico",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      "Inquadra il qr code e rispondi al sondaggio"),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: QrImage(
                                      data:
                                          "https://forms.gle/CfmcRJi3G1fjwo4n9",
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      Helper(
                        const Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 30,
                        ),
                        "Raddoppia le possibilità",
                        () {},
                      ),
                      const SizedBox(width: 15),
                      Helper(
                        const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 30,
                        ),
                        "Cambia la domanda",
                        () {
                          _questionAnswers[_index] = _bonusQuestion;
                          setState(() {});
                        },
                      ),
                      const Spacer(),
                      _index != 0
                          ? IconButton(
                              icon: const Icon(
                                Icons.arrow_left,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _index--;
                                setState(() {});
                              },
                            )
                          : const SizedBox(),
                      Text(
                        (_index + 1).toString() + " / 15",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      _index < 14
                          ? IconButton(
                              icon: const Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                _index++;
                                setState(() {});
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              child: ConfettiWidget(
                confettiController: _confettiController,
                numberOfParticles: 100,
                blastDirection: -pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 100,
                shouldLoop: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _index = 0;
  late ConfettiController _confettiController;

  final QuestionAnswers _bonusQuestion = QuestionAnswers(
      "Quale tra queste città è la capitale dell'Argentina?",
      ["Lima", "San Paolo", "Rio de Janeiro", "Buenos Aires"],
      3);

  final List<QuestionAnswers> _questionAnswers = [
    QuestionAnswers(
        "E' un piatto a base di carne tipico della cucina turca divenuto popolare in tutto il mondo.",
        ["Menemen", "Kebab", "Ramen", "Dolma"],
        1),
    QuestionAnswers(
        "E' un alcaloide naturale presente nelle piante di caffè, cacao o thè.",
        ["Teina", "Nitroglicerina", "Auxina", " Anidride carbonica"],
        0),
    QuestionAnswers(
        "E' un latticino ottenuto riscaldando, con o senza aggiunta di acidificanti, il siero residuato dalla lavorazione del formaggio.",
        ["Mozzarella", "Provolone", "Strutto", "Ricotta"],
        3),
    QuestionAnswers("Qual è il pianeta più grande del sistema solare?",
        ["Urano", "Giove", "Plutone", "Venere"], 1),
    QuestionAnswers(
        "Quali sono gli ingredienti della ricetta dei ceci di nonna Lucia?",
        [
          "Pepe nero, pomodoro",
          "Cipolla, carota, acqua",
          "Olio, sale, acqua",
          "Sedano, carote, cipolla, acqua"
        ],
        2),
    QuestionAnswers(
        "Quali tra queste sono le lingue ufficiali del Canada?",
        [
          "Inglese e Portoghese",
          "Inglese e Inuit",
          "Francese e Inuit",
          "Inglese e Francese"
        ],
        3),
    QuestionAnswers(
        "Quali tra questi è il piatto più ambito in casa?",
        [
          "Findus al burro",
          "Pasta salsiccia e funghi",
          "Funghi alla potatoes",
          "Sfogliatine di Meri",
        ],
        1),
    QuestionAnswers(
        "Se tu fossi Albert King quale sarebbe la tua professione?",
        [
          "Scrittore",
          "Giornalista televisivo",
          "Pilota formula 1",
          "Musicista"
        ],
        3),
    QuestionAnswers(
        "Le cellule staminali sono cellule dotate di due proprietà. Quali?",
        [
          "Autorinnovamento e ringiovanimento",
          "Autorinnovamento e potenziale di differenziamento",
          "Potenziale di differenziamento e ringiovanimento",
          "Ringiovanimento e attacchimento",
        ],
        1),
    QuestionAnswers(
        "Quali tra queste è la corretta traduzione italiana di 'Haute Couture'?",
        ["Molta fame", "Tanto sonno", "Alta moda", "Alta cerimonia"],
        2),
    QuestionAnswers(
        "Quanti fusi orari ci sono in Russia?", ["6", "5", "1", "11"], 3),
    QuestionAnswers("Quante strisce ci sono sulla bandiera americana?",
        ["13", "22", "50", "41"], 0),
    QuestionAnswers("In che anno fu fondata l'università di Catania?",
        ["1434", "1424", "1406", "1600"], 0),
    QuestionAnswers("Con che arma Samuele intimorì il bullo a scuola?",
        ["Mazzo di chiavi", "Sedia", "Tirapugni", "Coltello"], 0),
    QuestionAnswers(
        "Qual è il numero che completa la successione 53, ..., 71, 80, 89 ?",
        ["63", "62", "65", "64"],
        1),
  ];

  void _check(int index) {
    if (index == _questionAnswers[_index].rightAnswerIndex) {
      if (_index < 14) {
        _index++;
        setState(() {});
      } else {
        backgroundAudioPlayer.dispose();
        _confettiController.play();
      }
    }
  }

  bool _isCorrect(int index) {
    if (index == _questionAnswers[_index].rightAnswerIndex) return true;
    return false;
  }

  Future _playBackgroundMusic() async {
    await backgroundAudioPlayer.setAsset('assets/background.mp3');
    await backgroundAudioPlayer.play();
    await backgroundAudioPlayer.setLoopMode(LoopMode.all);
  }
}
