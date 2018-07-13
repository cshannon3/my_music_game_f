import 'dart:async';

import 'package:flutter/services.dart';




class FlutterSoundPlugin {
  static const MethodChannel _channel =
  const MethodChannel('flutter_sound_plugin');

  static Future<String> get platformVersion =>
      _channel.invokeMethod('getPlatformVersion');


  Future<Null> playnote(double freqHz, int durationMs) async {
    print("play note");
    try {
      /*final String result =*/ await _channel.invokeMethod('play_note',
          <String, dynamic>{
            "freqHZ": freqHz,
            "durationMS": durationMs
          }); //Replace a 'X' with 10 digit phone number
      //  print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<Null> playguitar() async {
    print("play guitar");
    try {
      /*final String result =*/ await _channel.invokeMethod('play_guitar',
         /* <String, dynamic>{
            "freqHZ": freqHz,
            "durationMS": durationMs
          }*/); //Replace a 'X' with 10 digit phone number
      //  print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }




}

