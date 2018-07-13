package io.flutter.plugins;

import android.app.Activity;
import android.content.ContentResolver;
import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.provider.MediaStore;
import android.util.Log;

import com.cshannon.mymusicgamef.MainActivity;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;


public class FlutterSoundPlugin implements MethodChannel.MethodCallHandler {
    private MethodChannel channel;
    private Activity activity;
    private PluginRegistry.Registrar registrar;
    public ContentResolver contentResolver;

    final Handler handler = new Handler();

    public static void registerWith(PluginRegistry registry) {

        PluginRegistry.Registrar  registrar = registry.registrarFor("flutter_sound_plugin");
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sound_plugin");
        channel.setMethodCallHandler(new FlutterSoundPlugin());
        return;
    }

    public void registercont(PluginRegistry.Registrar registraree) {

        registrar = registraree;
        contentResolver = registrar.context().getContentResolver();
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("play_note")) {
            double freqHZ = methodCall.argument("freqHZ");
            int durationMS = methodCall.argument("durationMS");
            AudioTrack tone = generateTone(freqHZ, durationMS);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
                tone.play();
            }
        } else  if (methodCall.method.equals("play_guitar")) {
            Log.e("On Method Call", "Play guitar");
           // playG();
        }

    }

    private AudioTrack generateTone(double freqHz, int durationMs)
    {
        int count = (int)(44100.0 * 2.0 * (durationMs / 1000.0)) & ~1;
        short[] samples = new short[count];
        for(int i = 0; i < count; i += 2){
            short sample = (short)(Math.sin(2 * Math.PI * i / (44100.0 / freqHz)) * 0x7FFF);
            samples[i + 0] = sample;
            samples[i + 1] = sample;
        }
        AudioTrack track = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.CUPCAKE) {
            track = new AudioTrack(AudioManager.STREAM_MUSIC, 44100,
                    AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT,
                    count * (Short.SIZE / 8), AudioTrack.MODE_STATIC);

            track.write(samples, 0, count);

        }
        return track;
    }
 /*   private MediaStore.Audio playG()
    {

        MediaPlayer mediaPlayer = new MediaPlayer();
        try {
            mediaPlayer.setDataSource(registrar.context(), R.raw.piano_E.mp3);
        } catch (IOException e) {
            e.printStackTrace();
        }
        mediaPlayer.start();
       // mediaPlayer.create(registrar.activeContext(),  Uri.parse("android.resource://com.cshannon.mymusicgamef/res/raw/piano_D.mp3"));
       // mediaPlayer.start();
        Log.e("PLay G", "Play g");

    }*/
}
