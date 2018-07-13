import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_music_game_f/screens/historyPage.dart';
import 'package:my_music_game_f/models/gameMode.dart';

import 'package:my_music_game_f/screens/main_gameScreen.dart';
import 'package:my_music_game_f/screens/piano_screen.dart';

void main() => runApp(//new game_screen());//TestApp());
new MaterialApp(
title: "Music App",
theme: new ThemeData.dark(),
home: new mainScreen(),
));

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => new _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  List<gameMode> gamemodes = gameModes;

  List<Widget> _buildGameModeTiles() {
    List<Widget> gamemodeTiles = [];
    gamemodes.forEach((game) {
      gamemodeTiles.add(_buildGameModeTile(game));
    });
    return gamemodeTiles;
  }
  Widget _buildGameModeTile(gameMode game) {
    return RaisedButton(
      child: Text(game.gameName),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => multi_game_screen(gamemode: game,)),
        );
      }, // onPress
    ); // Raised Button
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
    length: 3,

       child: Scaffold(
      appBar: AppBar(

        title: Text('First Screen'),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: 'Home Page',
            ), // Tab
            Tab(
              icon: Icon(Icons.history),
              text: 'History',
            ), // Tab
            Tab(
              icon: Icon(Icons.music_note),
              text: 'Piano',
            ), // Tab
          ],
        ),
      ),
      body: TabBarView(
          children :  [
      Center(
    child: ListView(
      children : _buildGameModeTiles(),

    ), // ListView
    ),

            historyPage(),
      pianoScreen(),
          ]
      ), // TabBarView

    )
    );
  }
}






