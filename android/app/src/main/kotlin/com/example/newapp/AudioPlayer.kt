package com.example.newapp

import android.media.MediaPlayer
import android.media.AudioAttributes

import kotlinx.coroutines.*

class AudioPlayer {

    private val mediaPlayer = MediaPlayer()
    private var isPrepared = false
    private var isPlaying = false

    fun play(url: String) {
        stop()
        mediaPlayer.setDataSource(url)
        mediaPlayer.prepare()
        mediaPlayer.setAudioAttributes(
                             AudioAttributes
                            .Builder()
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            .build());
        mediaPlayer.setOnPreparedListener {
            isPrepared = true
            mediaPlayer.start()
            isPlaying = true
        }
    }

    fun pause() {
        if (isPlaying) {
            mediaPlayer.pause()
            isPlaying = false
        }
    }

    fun stop() {
        mediaPlayer.stop()
        mediaPlayer.reset()
        isPrepared = false
        isPlaying = false
    }
}
