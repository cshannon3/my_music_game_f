package com.cshannon.mymusicgamef;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.FlutterSoundPlugin;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.PluginRegistry;

public class MainActivity extends FlutterActivity {
  private String CHANNEL = "play_note";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    GeneratedPluginRegistrant.registerWith(this);
    FlutterSoundPlugin.registerWith(this);
  }
}
