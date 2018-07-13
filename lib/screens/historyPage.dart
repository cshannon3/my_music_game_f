
import 'package:flutter/material.dart';
import 'package:my_music_game_f/database/database.dart';
import 'package:my_music_game_f/models/finishedgame.dart';
//import 'package:flutter_charts/flutter_charts.dart';
class historyPage extends StatefulWidget {
  @override
  _historyPageState createState() => new _historyPageState();
}

class _historyPageState extends State<historyPage> {
  GameHistoryDatabase myDB;
  List<finishedGame> games = [];
  List<Widget> historyTiles = [];
  bool hasLoaded = false;
  //LineChartOptions _lineChartOptions;
  //ChartData _chartData;

  @override
  void initState() {
    super.initState();
    if (mounted) loadHistory();
  }
  /*void defineOptionsAndData() {
    _lineChartOptions = new LineChartOptions();
    // _xContainerLabelLayoutStrategy = null;
    _chartData = new RandomChartData(useUserProvidedYLabels:  false
       // useUserProvidedYLabels: _lineChartOptions.useUserProvidedYLabels
    );
  }*/


  loadHistory() async {
    setState(() =>
      hasLoaded = false,
    );
    myDB = GameHistoryDatabase();
    await myDB.getAllHistory().then((allHistory) {
      setState(() {
        games = allHistory;
        games.sort((a,b) => b.score.compareTo(a.score));
        historyTiles = _buildEntries();

      });
    });
    setState(() {
      hasLoaded = true;
    });
  }
  List<Widget> _buildEntries() {
    List<Widget> historytiles = [];
    for (var i = 0; i < games.length; ++i) {
      print(games[i].date);
      historytiles.add(_buildGameRow(i+1, games[i]));
    }
    return historytiles;
  }
  Widget _buildGameRow(int entrynum, finishedGame game) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("$entrynum"),
          Text(game.gameType),
          Text("${(game.score*100).floor()}%"),
          Text("${game.time} secs"),
        ],
      ), // Row
    ); // Padding
  }

  /*void _chartStateChanger() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed state without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.

      /// here we create new random data to illustrate state change
       defineOptionsAndData();
    });
  }*/
  @override
  Widget build(BuildContext context) {
    /*defineOptionsAndData();
   LineChart lineChart = new LineChart(
      painter: new LineChartPainter(),
    layouter  : new LineChartLayouter(
        chartData: _chartData, // @required
        chartOptions: _lineChartOptions, // @required
      ),
    );*/
    return new Center(
      child: ListView(
            children: hasLoaded ? historyTiles: [Container()],//_buildCountryTiles(),
          ),
        /*  new Expanded(
            // expansion inside Column pulls contents |
             child: new Row(
              // this stretch carries | expansion to <--> Expanded children
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Text('>>>'),
                // LineChart is CustomPaint:
                // A widget that provides a canvas on which to draw
                // during the paint phase.

                // Row -> Expanded -> Chart expands chart horizontally <-->
                new Expanded(
                  child: lineChart,
                ),
                // new Text('<<'), // horizontal
                // new Text('<<<<<<'),   // tilted
                // new Text('<<<<<<<<<<<'),   // skiped (shows 3 labels, legend present)
                // new Text('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'), // skiped (shows 2 labels, legend present but text vertical)
                // new Text('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'),// labels do overlap, legend NOT present
                new Text('<<<<<<'),// labels do overlap, legend NOT present
              ],
            ),
          ),
             new RaisedButton(
               color: Colors.green,
               onPressed: _chartStateChanger,
             ),*/

      //  ],
     // ),
    );
  }
}
