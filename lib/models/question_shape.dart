import 'package:chivuolesserelaureato/utils/players.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class QuestionShape extends StatefulWidget {
  final String text;
  final bool isQuestion;
  final Function onTap;
  final bool isCorrect;

  const QuestionShape(this.text, this.isQuestion, this.onTap, this.isCorrect,
      {Key? key})
      : super(key: key);

  @override
  _QuestionShapeState createState() => _QuestionShapeState();
}

class _QuestionShapeState extends State<QuestionShape> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.isQuestion
          ? () async {
              _isPressed = true;
              _color = Colors.amber;
              setState(() {});
              await Future.delayed(const Duration(seconds: 1));
              if (widget.isCorrect) {
                _color = Colors.green;
                await _playSuccessMusic();
              } else {
                _color = Colors.red;
                await _playErrorMusic();
              }
              setState(() {});
              await Future.delayed(
                const Duration(seconds: 2),
              );
              _isPressed = false;
              setState(() {});
              widget.onTap();
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: _isPressed ? _color : const Color.fromRGBO(34, 62, 149, 1),
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Padding(
          padding: widget.isQuestion
              ? const EdgeInsets.all(30.0)
              : const EdgeInsets.all(10.0),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: widget.text[0],
                style: TextStyle(
                    fontSize: 25,
                    color: widget.isQuestion ? Colors.white : Colors.amber,
                    fontWeight: widget.isQuestion
                        ? FontWeight.bold
                        : FontWeight.normal),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.text.substring(1, widget.text.length),
                    style: TextStyle(
                        fontSize: widget.isQuestion ? 25 : 20,
                        color: Colors.white,
                        fontWeight: widget.isQuestion
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isPressed = false;
  late Color _color;

  Future _playSuccessMusic() async {
    successAudioPlayer = AudioPlayer();
    await successAudioPlayer.setAsset('assets/success.mp3');
    await backgroundAudioPlayer.pause();
    await successAudioPlayer.play();
    await backgroundAudioPlayer.play();
  }

  Future _playErrorMusic() async {
    errorAudioPlayer = AudioPlayer();
    await errorAudioPlayer.setAsset('assets/error.mp3');
    await backgroundAudioPlayer.pause();
    await errorAudioPlayer.play();
    await backgroundAudioPlayer.play();
  }
}
