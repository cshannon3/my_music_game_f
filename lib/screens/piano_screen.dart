import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

List<String> notesC = ["middle_C", "C_sharp", "D", "D_sharp", "E", "F", "F_sharp", "G", "G_sharp", "A", "A_sharp", "B"];
List<int> sharps = [49, 51 ,54,56, 58, 61 , 63, 66, 68, 70];

class pianoScreen extends StatefulWidget {
  @override
  _pianoScreenState createState() => new _pianoScreenState();
}

class _pianoScreenState extends State<pianoScreen> {

  List<Widget> _buildKeys2() {
    List<Widget> keys = [];
    for (int p = 48; p< 72; ++p) {
      keys.add(_buildKey2(p));
    }
    return keys;
    // 49 C#/ 51 D#/ 54 F#/ 56 G#/ 58 A#/ //61 / 63/ 66/ 68/ 70
  }
  _playNote(int keyname) async {
    await Flame.audio.play("piano_${keyname}.mp3");
  }
  Widget _buildKey2(int keyname) {
    return GestureDetector(
      onTap: () {_playNote(keyname);},
      onLongPress: () {} ,
      child: new Container(
        height: 60.0,
        width: double.infinity,
        //color: (keyname.contains("sharp")) ? Colors.black : Colors.white10,
        decoration: BoxDecoration(

            color: (sharps.contains(keyname)) ? Colors.black : Colors.white,
            border: Border(
              left: BorderSide(color: Colors.white24, width: 1.0),
              right: BorderSide(color: Colors.white24, width: 1.0),
              bottom: BorderSide(color: Colors.white24, width: 1.0),

            )

        ),
        padding: EdgeInsets.all(1.0),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Music App",
        theme: new ThemeData.dark(),
        home:
        new Padding(
        padding: const EdgeInsets.only(top: 30.0),
    child: Center(
      child: new ListView(

          children: _buildKeys2(),

      ), // ListView
    ), // Center
    ), // Padding
    ); //Material App
  }
}
