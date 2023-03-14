package com.example.newapp

import android.media.MediaPlayer
import android.media.AudioAttributes
import android.util.Log

import kotlinx.coroutines.*


class AudioPlayer {

    private val mediaPlayer = MediaPlayer()
    private var isPrepared = false
    private var isPlaying = false
    private var length = 0

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
            length=mediaPlayer.getCurrentPosition()
            Log.v("Tag", length.toString())
        }
    }

    fun resume() {
        Log.v("Tag", length.toString())
        if (!isPlaying) {
            mediaPlayer.seekTo(length)
            mediaPlayer.start()
            isPlaying = true
        }
    }

    fun stop() {
        mediaPlayer.stop()
        mediaPlayer.reset()
        isPrepared = false
        isPlaying = false
    }
}
