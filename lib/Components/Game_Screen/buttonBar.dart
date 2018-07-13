

import 'package:flutter/material.dart';
List<String> notesC = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

class buttonsBar extends StatelessWidget {
  final int freqIndex;
  final int anstype;
  final VoidCallback play;
  final Function resetGame;

  buttonsBar({
    this.freqIndex,
    this.anstype,
    this.play,
    this.resetGame
  });

  Widget buildButton(String title, VoidCallback onPress) {
    return RaisedButton(
      onPressed: () { onPress();},
      child: RichText(
        text: TextSpan(
          text: title,
        ), // Text Span
      ), // RichText
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildButton("Repeat", play),
                buildButton("Restart", resetGame),
               RaisedButton(
                  onPressed: () {Navigator.pop(context);},
                  child: RichText(
                    text: TextSpan(
                      text: "Go Home",
                    ), // Text Span
                  ), // RichText
                ),
              ],
            ),
          ), // IconButton
          Container(
            height: 75.0,
            width: 75.0,
            child: (anstype==2) ? CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(notesC[freqIndex])
            ): Container(),
            // ),
          ),
        ],
      ), // Row
    ); //Padding;
  }
}