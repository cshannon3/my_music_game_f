

class finishedGame {
  final String gameType;
  final double score;
  final String time;
  final String date;

  finishedGame({
    this.gameType,
    this.score,
    this.time,
    this.date,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['game_type'] = gameType;
    map['score'] = score;
    map['time'] = time;
    map['date'] = date;

    return map;
  }

  finishedGame.fromOfflineDB(Map map)
      : gameType = map["game_type"],
        score = map["score"],
        time = map["time"],
        date = map["date"];
}