import 'dart:math';

import 'package:flutter/material.dart';
List<String> notesC = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
List<List<int>> scales = [[0,2,4,5,7,9,11,12], // major Scale
[0,2,3,5,7,8,10,12], // minor Scale
[0,2,3,5,7,8,11,12], // harmonic
[0,2,3,5,7,9,11,12], // melodic
[0,2,3,5,6,7,11,12]  // Blues scale
];
List<String> scaleNames = ["Major", "Minor", "Harmonic", "Melodic", "Blues"];

class answer_choices_Widget extends StatelessWidget {
  final bool ofscales;
  final int anstype;
  final int correctIndex;
  final int freqIndex;
  final Function(int index) onPress;
  List<int> optionIndexes = [];
  int correctposition;
  Random random;
  answer_choices_Widget({
    this.ofscales,
    this.anstype,
    this.correctIndex,
    this.freqIndex,
    this.onPress,
  });
  List<Widget> choicelist = [];
  List<Color> colorchoicesC = [
    Colors.amber, Colors.yellow, Colors.green, Colors.greenAccent,
    Colors.blue, Colors.indigo, Colors.indigo[200], Colors.purple,
    Colors.purple[200], Colors.red, Colors.pink, Colors.orange,
  ];

  String _buildScaletext(int rootnote, int scale) {
    String scaletext = "";
    for (int i in scales[scale]) {
      scaletext += notesC[rootnote+i] + " ";
    }
    return scaletext;
  }

  List<Widget> _buildChoiceTiles(int correctindex, int anstype, bool scales, int freqindex) {
    List<Widget> newChoicelist = [];

    optionIndexes.clear();
    random = new Random();
    correctposition = random.nextInt(3);

    for (int i = 0; i < 4; ++i) {
      if (i == correctposition) {

        newChoicelist.add(_buildChoiceTile(correctindex, scales, anstype, freqindex));
        optionIndexes.add(correctindex);
      }
      else {
        int numofoptions = (anstype==2) ? 5 : 12;
        int choiceindex = random.nextInt(numofoptions);
        while (optionIndexes.contains(choiceindex) ||
            choiceindex == correctindex) {
          choiceindex = random.nextInt(numofoptions);
        }
        optionIndexes.add(choiceindex);
        newChoicelist.add(_buildChoiceTile(choiceindex, scales, anstype, freqindex));
      }
    }
    // add a setter func here
    choicelist = newChoicelist;

    return newChoicelist;
  }


  Widget _buildChoiceTile(int index, bool scale, int gametype, int freqindex) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Container(
        //color: Colors.red, //colorchoices[index],
        child: new RaisedButton(
          color: colorchoicesC[index],
          onPressed: () => onPress(index),
          child: scale ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(text: (gametype==2) ? scaleNames[index] : notesC[index], style: TextStyle(
                  color: Colors.white,
                ), // Text Style
                ), // Text Span
                textDirection: TextDirection.ltr,
              ), // RichText

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: TextSpan(text: (gametype==2) ? _buildScaletext(freqindex, index): _buildScaletext(index, 0), style: TextStyle(
                    color: Colors.white,
                  ), // Text Style
                  ), // Text Span
                  textDirection: TextDirection.ltr,
                ),
              ), // RichText
            ],
          ) : Center(
            child: RichText(
              text: TextSpan(text: notesC[index], style: TextStyle(
                color: Colors.white,
              ), // Text Style
              ), // Text Span
              textDirection: TextDirection.ltr,

            ), // RichText
          ), // Center
        ), // RaisedButton
      ),
    ); // Padding
  }
  @override
  Widget build(BuildContext context) {
    return Container(

        child: new GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          children: _buildChoiceTiles(correctIndex, anstype, ofscales, freqIndex),
        ),

    );
  }
}
