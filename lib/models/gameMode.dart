final List<gameMode> gameModes = [
  gameMode(
    gameName: "PianoBasic",
    description: "Guess the Note being played on piano",
    oneNote: false,
    ofscales: false,
    anstype: 0,
    instrument: "piano",
    timelimit: 10000,
    cards: 20
  ),
  gameMode(
      gameName: "Scales",
      description: "Guess the Note being played on piano",
      oneNote: false,
      ofscales: true,
      anstype: 1,
      instrument: "piano",
      timelimit: 10000,
      cards: 20
  ),
  gameMode(
      gameName: "ScaleTypeOneNote",
      description: "Guess the scale type of a single note",
      oneNote: true,
      ofscales: true,
      anstype: 2,
      instrument: "piano",
      timelimit: 10000,
      cards: 20
  ),
  gameMode(
      gameName: "ScaleType",
      description: "Guess the scale type of random notes",
      oneNote: false,
      ofscales: true,
      anstype: 2,
      instrument: "piano",
      timelimit: 10000,
      cards: 20
  ),
];



class gameMode {
  final String gameName;
  final String description;
  final bool oneNote;
  final bool ofscales;
  final int anstype;
  final String instrument;
  final int timelimit;
  final int cards;

  gameMode({
    this.anstype,
    this.oneNote,
    this.instrument,
    this.description,
    this.gameName,
    this.ofscales,
    this.cards,
    this.timelimit,
});

  /*Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['game_'] = gameType;
    map['score'] = score;
    map['time'] = time;
    map['date'] = date;

    return map;
  }*/

}