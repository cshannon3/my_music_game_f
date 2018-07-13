import 'package:flutter/material.dart';
import 'package:my_music_game_f/Components/Game_Screen/buttonBar.dart';
import 'package:my_music_game_f/Components/Game_Screen/finished_gameBox.dart';

import 'dart:async';

import 'package:my_music_game_f/Components/Game_Screen/TopBar.dart';
import 'dart:math';
import 'package:flame/flame.dart';
import 'package:my_music_game_f/Components/Game_Screen/answerChoicesWidget.dart';
import 'package:my_music_game_f/models/gameMode.dart';
double fc0 = 130.81;
double a = pow(2, 1/12);

List<String> notesC = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
List<List<int>> scales = [[0,2,4,5,7,9,11,12], // major Scale
[0,2,3,5,7,8,10,12], // minor Scale
[0,2,3,5,7,8,11,12], // harmonic
[0,2,3,5,7,9,11,12], // melodic
[0,2,3,5,6,7,11,12]  // Blues scale
];
List<String> scaleNames = ["Major", "Minor", "Harmonic", "Melodic", "Blues"];

class multi_game_screen extends StatefulWidget {
  final gameMode gamemode;
  multi_game_screen({this.gamemode});


  @override
  multi_game_screenState createState() => new multi_game_screenState();
}

class multi_game_screenState extends State<multi_game_screen> {
  int freqIndex, pianoKey, totalcards, cardnum, correctnum, streak,
      correctIndex;
  bool canPress, gameFinished, winningstreak;
  String lastAns;
  Color flashcolor;
  Widget answerChoices;
  Stopwatch stopwatch = Stopwatch();
  Timer timer;
  Random random;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flashcolor = Colors.blue;
    canPress = false;
    gameFinished = false;
    random = new Random();
    totalcards = 20;
    resetGame();
  }

  void resetGame() {
    setState(() {
      gameFinished = false;
    });
    streak = 0;
    winningstreak = true;
    cardnum = 0;
    correctnum = 0;
    stopwatch.reset();
    timer?.cancel(); // cancel old timer if it exists
    //Start new timer
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {});
      stopwatch.start();
    });
    // freqIndex is initial note
    freqIndex = random.nextInt(12);
    // piano key corresponds to audio files/keys
    pianoKey = freqIndex + 48;
    correctIndex = (widget.gamemode.anstype == 2) ? random.nextInt(5) : freqIndex;
    _play(widget.gamemode.anstype, widget.gamemode.ofscales, pianoKey, correctIndex);

    setState(() {
      answerChoices = answer_choices_Widget(ofscales: widget.gamemode.ofscales,
        correctIndex: correctIndex,
        anstype: widget.gamemode.anstype,
        freqIndex: freqIndex,
        onPress: onPress,);
      canPress = true;
    });
  }

  void onPress(int index) {
    setState(() {
      canPress = false;
      cardnum += 1;
      lastAns =
      (widget.gamemode.anstype == 2) ? scaleNames[correctIndex] : notesC[correctIndex];
    });
    //double cardfreq = f0 * pow(a, (index - 3) * 12);
    if (index == correctIndex) {
      setState(() {
        _playBing();
        if (winningstreak) {
          streak += 1;
        } else {
          streak = 1;
          winningstreak = true;
        }
        flashcolor = Colors.green;
        correctnum += 1;
      });
    } else {
      // double wrongFreq = f0 * pow(a, index);
      // print("${notesC[index]} is Incorrect, ${notesC[freqIndex]} is correct");
      setState(() {
        if (!winningstreak) {
          streak += 1;
        } else {
          streak = 1;
          winningstreak = false;
        }
        flashcolor = Colors.red;
      });
    }
    if (cardnum < totalcards) {
      Duration d = Duration(milliseconds: 500);
      Future.delayed(d).then((r) {
        print("$cardnum");
        if (!widget.gamemode.oneNote) freqIndex = random.nextInt(12);
        pianoKey = freqIndex + 48;
        correctIndex = (widget.gamemode.anstype == 2) ? random.nextInt(5) : freqIndex;
        setState(() {
          answerChoices = answer_choices_Widget(ofscales: widget.gamemode.ofscales,
            correctIndex: correctIndex,
            anstype: widget.gamemode.anstype,
            freqIndex: freqIndex,
            onPress: onPress,);
          _play(widget.gamemode.anstype, widget.gamemode.ofscales, pianoKey, correctIndex);
          canPress = true;
          print("playnote");
        });
      });
    }
    else {
      stopwatch.stop();
      timer.cancel();
      setState(() {
        gameFinished = true;
      });
    }
  }

  _playBing() async {
    await Flame.audio.play("Bing-sound.mp3");
  }

  _play(int anstype, bool scales, int pianokey, int scaleint) {
    if (anstype == 2) {
      _playScale(pianokey, scaleint, 0);
    }
    else if (scales) {
      _playScale(pianokey, 0, 0);
    }
    else {
      _playNote(pianokey);
    }
  }

  void playfromoutside() {
    if (widget.gamemode.anstype == 2) {
      _playScale(pianoKey, correctIndex, 0);
    }
    else if (widget.gamemode.ofscales) {
      _playScale(pianoKey, 0, 0);
    }
    else {
      _playNote(pianoKey);
    }
  }

  _playScale(int rootkey, int scaleint, int currentint) async {
    print("${rootkey + scales[scaleint][currentint]}");

    Flame.audio.play("piano_${rootkey + scales[scaleint][currentint]}.mp3")
        .whenComplete(() {
      Duration d = Duration(milliseconds: 500);
      if (currentint < 7) {
        currentint += 1;
        Future.delayed(d).then((r) {
          // setState(() {
          _playScale(rootkey, scaleint, currentint);
        });

        // });
      }
    });
  }

  _playNote(int keyname) async {
    await Flame.audio.play("piano_${keyname}.mp3");
  }

  @override
  Widget build(BuildContext context) {
    int timeElapsed = stopwatch.elapsedMilliseconds ~/ 1000;
    int cardsleft = totalcards - cardnum;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Stack(
              children: [
                Center(
                  child: Column(
                      children: <Widget>[
                        // Timer
                        TopBar(
                          timeElapsed: timeElapsed,
                          cardnum: cardnum,
                          correct: correctnum,
                          cardsleft: cardsleft,
                        ),
                        buttonsBar(freqIndex: freqIndex,
                          anstype: widget.gamemode.anstype,
                          play: playfromoutside,
                          resetGame: resetGame,),

                        Expanded(

                            child: answerChoices
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 100.0,
                              width: double.infinity,
                              color: flashcolor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Correct Answer = ${lastAns}",
                                    style: TextStyle(color: Colors.white),),
                                  Text(winningstreak
                                      ? "Correct Streak: $streak"
                                      : "Incorrect Streak: $streak")
                                ],
                              )
                          ),
                        ),
                      ]
                  ), // Column
                ), // Center
                gameFinished ? finishedGameBox(
                  correctnum: correctnum,
                  totalcards: cardnum,
                  timeElapsed: timeElapsed,
                  resetGame: resetGame,) : Container()
              ]
          ), // Stack
        )
    );
  }
}


