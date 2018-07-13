import 'package:flutter/material.dart';
import 'package:my_music_game_f/database/database.dart';
import 'package:my_music_game_f/models/finishedgame.dart';

class finishedGameBox extends StatefulWidget {
  final int correctnum;
  final int totalcards;
  final int timeElapsed;
  final Function resetGame;

  finishedGameBox({
    this.correctnum,
    this.totalcards,
    this.timeElapsed,
    this.resetGame
  });

  @override
  _finishedGameBoxState createState() => new _finishedGameBoxState();
}

class _finishedGameBoxState extends State<finishedGameBox> {

  void saveGame(String timeElapsed) async {
    GameHistoryDatabase myDB = new GameHistoryDatabase();
    finishedGame game = finishedGame(gameType: "scalegame1", score:(widget.correctnum / widget.totalcards).toDouble(), time: "$timeElapsed", date: DateTime.now().toString());
    int res = await myDB.addGame(game);
    print("game added: $res");
  }
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.blue,
          height: 300.0,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: RichText(
                    text: TextSpan(text: "${widget.correctnum} / ${widget.totalcards}")),
              ),
              Center(
                child: RichText(
                    text: TextSpan(text: "Time Elapesd ${widget.timeElapsed}")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Go to Home",
                        ), // Text Span
                      ), // RichText
                    ), // IconButton
                    RaisedButton(
                      onPressed: () {widget.resetGame(); },
                      child: RichText(
                        text: TextSpan(
                          text: "Play Again",
                        ), // Text Span
                      ), // RichText
                    ), // IconButton
                    RaisedButton(
                      onPressed: () {
                        saveGame("${widget.timeElapsed}");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Save",
                        ), // Text Span
                      ), // RichText
                    ), // IconButton
                  ],
                ), // Row
              ), //Padding
            ],
          ),
        ),
      ),
    );
  }
}
