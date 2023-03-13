package com.example.newapp

import android.media.AudioManager
import android.media.MediaPlayer
import androidx.annotation.NonNull
import android.media.AudioAttributes

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

import com.example.newapp.AudioPlayer


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val audioPlayer = AudioPlayer()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "audio_player").setMethodCallHandler { call, result ->
            GlobalScope.launch(Dispatchers.Main) {
                when (call.method) {
                    "play" -> {
                        val url = call.argument<String>("url")!!
                        audioPlayer.play(url)
                        result.success(null)
                    }
                    "pause" -> {
                        audioPlayer.pause()
                        result.success(null)
                    }
                    "stop" -> {
                        audioPlayer.stop()
                        result.success(null)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }
        }
    }
}